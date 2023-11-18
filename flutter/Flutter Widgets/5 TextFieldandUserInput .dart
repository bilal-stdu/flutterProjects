import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var emailText = TextEditingController();
    var passwordText = TextEditingController();
    return MaterialApp(
        title: 'Flutter Layout Demo',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('User input demo'),
          ),
          body: Center(
              child: Container(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailText,
                        // enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                                width: 2,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: const BorderSide(
                                color: Colors.blueAccent,
                                width: 2,
                              )),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: const BorderSide(
                                color: Colors.black45,
                                width: 2,
                              )),
                          // suffixText: "Username exits",
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      TextField(
                        controller: passwordText,
                        obscureText: true,
                        // obscuringCharacter: '',
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                                width: 2,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                                width: 2,
                              )),
                          suffixIcon: IconButton(
                            icon:
                            const Icon(Icons.remove_red_eye, color: Colors.teal),
                            onPressed: () {},
                          ),
                        ),

                      ),
                      ElevatedButton(
                          onPressed: () {
                            String userEmail = emailText.text.toString();
                            String userPassword = passwordText.text.toString();

                            print("Email: $userEmail, Password: $passwordText");
                          },
                          child: Text('Login',))
                    ],
                  ))),
        ));
  }
}
