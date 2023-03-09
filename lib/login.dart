import 'package:flutter/material.dart';
import 'package:flutter_php/crud.dart';
import 'package:flutter_php/linkapi.dart';
import 'package:flutter_php/main.dart';
import 'package:flutter_php/signup.dart';

import 'home.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  Crud crud = Crud();
  signInFunction() async {
    if (formstate.currentState!.validate()) {
      var response = await crud
          .postRequest(login, {"email": email.text, "password": password.text});
      setState(() {});
      print(response["status"]);
      if (response["status"] == "success") {
        sharedPref.setString("id", response['data']['id'].toString());
        sharedPref.setString("username", response['data']['username']);
        sharedPref.setString("passwordd", response['data']['password']);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        print("fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                        if (val.length < 2) {
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
                        await signInFunction();
                      },
                      child: Text(
                        "Sign in",
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                        child: Text("dont have an account ? Signup"))
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
