import 'package:flutter/material.dart';
import 'package:flutter_php/crud.dart';
import 'package:flutter_php/home.dart';
import 'package:flutter_php/linkapi.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  Crud _crud = Crud();
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  signUpFunction() async {
    if (formstate.currentState!.validate()) {
      loading = true;
      print("kjfbsadjfhjds");
      var response = await _crud.postRequest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text
      });
      loading = false;
      setState(() {});
      print(response["status"]);
      if (response["status"] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        print("fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formstate,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: username,
                            validator: (val) {
                              if (val!.length > 100) {
                                return "username can't be larger than 100";
                              }
                              if (val.length < 2) {
                                return "username can't be smaller than 2";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "username",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: email,
                            validator: (val) {
                              if (val!.length > 100) {
                                return "email can't be larger than 100";
                              }
                              if (val.length < 2) {
                                return "email can't be smaller than 2";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "email",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: password,
                            validator: (val) {
                              if (val!.length > 100) {
                                return "password can't be larger than 100";
                              }
                              if (val.length < 4) {
                                return "password can't be smaller than 4";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "password",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await signUpFunction();
                            },
                            child: Text(
                              "Sign Up",
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogIn()),
                                );
                              },
                              child: Text("dont have an account ? login"))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
