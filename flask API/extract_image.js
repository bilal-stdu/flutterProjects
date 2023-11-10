const AppError = require("../../utils/appError");
const catchAsync = require("../catchAsync");
const axios = require("axios");
const multer = require("multer");
const path = require("path");
const cloudinary = require("cloudinary").v2;
const { deleteLocalFile } = require("../../utils/fileUtility");
const fs = require("fs");

// Cloudinary Configuration
cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

// Configure multer for file storage
const diskStorage = multer.diskStorage({
  destination: function (req, file, cb) {
    // Go up three levels from __dirname, then into 'dev-data/uploads'
    cb(null, path.join(__dirname, "./assets"));
  },
  filename: function (req, file, cb) {
    // Set file name
    cb(
      null,
      file.fieldname + "-" + Date.now() + path.extname(file.originalname)
    );
  },
});

const upload = multer({
  storage: diskStorage,
  fileFilter: (req, file, cb) => {
    if (file.mimetype === "application/pdf") {
      cb(null, true);
    } else {
      cb(null, false);
    }
  },
  limits: {
    fileSize: 10485760, // 10 MB in bytes
  },
});

// Handle file upload locally
exports.uploadFile = upload.single("file");

exports.setFileName = (req, res, next) => {
  const file = req.file;
  // The base directory for the file, relative to the project root
  const baseDir = "dev-data/uploads/";
  const fullPath = file.path;

  // Extract the relative path after 'dev-data/uploads/'
  const relativePath = fullPath.includes(baseDir)
    ? fullPath.split(baseDir).pop()
    : fullPath;

  // It is assumed that the 'file.path' already contains the desired path
  // as set by the 'diskStorage.destination' above
  res.status(200).send({ file: relativePath, filePath: fullPath });
};

exports.deleteUploadedFile = catchAsync(async (req, res, next) => {
  const filePath = req.body.filePath;

  try {
    // Use fs.unlink to delete the file
    await deleteLocalFile(filePath);
    res.status(200).json({ message: "File deleted successfully" });
  } catch (error) {
    console.error(error);
    next(new AppError("Error While Reverting the File.", 400));
  }
});

// Handle file upload cloudinary
exports.handlePDFUpload = catchAsync(async (req, res, next) => {
  const filePath = req.body.filePath;
  let public_id = "";

  console.log(filePath);
  // if (!filePath) {
  //     return next(new AppError('No file uploaded!', 400));
  // }

  // Use fs.access to check if the file exists
  fs.access(filePath, fs.constants.F_OK, (err) => {
    if (err) {
      console.error(`The file "${filePath}" does not exist.`);
    } else {
      console.log(`The file "${filePath}" exists.`);
    }
  });

  try {
    const result = await cloudinary.uploader.upload(filePath, {
      resource_type: "raw",
    });

    const secureUrl = result.secure_url;
    public_id = result.public_id;

    // Construct the Flask URL with the Cloudinary URL parameter
    const flaskUrl = `https://extract-images.axiomkit.com/downloadImagesFromPdf?pdf_url=${secureUrl}`;

    console.log("Request is made to flask");
    // Make the request to Flask route
    const flaskResponse = await axios.get(flaskUrl);

    // Check Flask response status and handle errors if necessary
    if (flaskResponse.status !== 200) {
      return next(
        new AppError("Error processing the file in Flask service", 500)
      );
    }

    // console.log("Flask Response Data: " + JSON.stringify(flaskResponse.data));
    // console.log(`Flask Response Status: ${flaskResponse.status}`);
    // console.log(`Flask Response Headers: ${JSON.stringify(flaskResponse.headers)}`);

    res.status(200).json({
      status: "success",
      data: flaskResponse.data,
    });
  } catch (error) {
    console.log(error);
  } finally {
    //Delete File Locally
    await deleteLocalFile(filePath);

    // Destroy file in cloudinary
    // await cloudinary.uploader.destroy(public_id);
    console.log("File Deteled..");
  }
});
