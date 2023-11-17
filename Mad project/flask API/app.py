from flask import Flask, jsonify, request
from flask_restful import Api, Resource
from flask_cors import CORS
from flask_restful import reqparse
import fitz  # PyMuPDF
import requests
import cloudinary
import cloudinary.uploader
import os
import werkzeug



app = Flask(__name__)

# Enable CORS for all routes
CORS(app)

api = Api(app)

# Cloudinary Configuration
cloudinary.config( 
  cloud_name = "dizaihihn", 
  api_key = "549991823224913", 
  api_secret = "eeBzO-yhNXCThNNZcboTQzqFeqM" 
)

def delete_files_with_extension(directory_path, extensions=['.png', '.pdf', 'jpg', 'jpeg']):
    """
    Deletes files with the specified extensions in the given directory.

    Args:
    - directory_path (str): Path to the directory.
    - extensions (list): List of file extensions to match for deletion.
    """

    # Loop through all files in the directory
    for filename in os.listdir(directory_path):
        if filename.endswith(tuple(extensions)):
            file_path = os.path.join(directory_path, filename)
            try:
                os.remove(file_path)
                print(f"Deleted: {file_path}")
            except Exception as e:
                print(f"Error deleting {file_path}. Reason: {e}")


def extract_images_from_pdf(cloudinary_pdf_url):
    
    # 1. Download the PDF from Cloudinary link
    response = requests.get(cloudinary_pdf_url)
    with open("./assets/temp.pdf", "wb") as f:
        f.write(response.content)
    
    # 2. Extract images from the PDF using PyMuPDF
    pdf_document = fitz.open("./assets/temp.pdf")
    image_urls = []
    for page_number in range(pdf_document.page_count):
        page = pdf_document.load_page(page_number)
        image_list = page.get_images(full=True)
        for img_index, img in enumerate(image_list):
            xref = img[0]
            base_image = pdf_document.extract_image(xref)
            image_bytes = base_image["image"]

            # Save it locally
            image_filename = os.path.join("./assets", f"image{page_number+1}_{img_index+1}.png")
            with open(image_filename, "wb") as image_file:
                image_file.write(image_bytes)

            # 3. Upload the extracted image to Cloudinary
            upload_response = cloudinary.uploader.upload(image_filename)
            # 4. Append the Cloudinary URL to our list
            image_urls.append(upload_response["url"])
            
    return image_urls

class ExtractImagesFromPdf(Resource):
    def get(self):
        cloudinary_pdf_url = request.args.get('pdf_url')
        if not cloudinary_pdf_url:
            return {"error": "pdf_url parameter is required"}, 400
        
        extracted_image_links = extract_images_from_pdf(cloudinary_pdf_url)
        delete_files_with_extension("./assets")
        
        return {"image_links": extracted_image_links}, 200

class generalUrl(Resource):
    def get(self):
        return {"message": "Hello, Hope You are Doing Great !"}, 200
class UploadPdf(Resource):
    def post(self):
        # Parse the incoming request for 'pdf' file
        parse = reqparse.RequestParser()
        parse.add_argument('pdf', type=werkzeug.datastructures.FileStorage, location='files')
        args = parse.parse_args()

        # Get the 'pdf' file from the request
        pdf_file = args['pdf']

        # Check if a file was provided
        if pdf_file:
            # Upload the file to Cloudinary
            upload_response = cloudinary.uploader.upload(pdf_file, resource_type = "raw")
            
            # Return the URL of the uploaded file
            return {"pdf_url": upload_response['url']}, 200
        else:
            return {"error": "No file was provided"}, 400

#This is the Routes of Application
api.add_resource(ExtractImagesFromPdf, '/extractImagesFromPdf')
api.add_resource(generalUrl, '/greeting')
api.add_resource(UploadPdf, '/uploadPdf')


if __name__ == "__main__":
    app.run(debug=False)

#http://localhost:5000/uploadPdf
#http://localhost:5000/extractImagesFromPdf?pdf_url=Cloundinary_URL