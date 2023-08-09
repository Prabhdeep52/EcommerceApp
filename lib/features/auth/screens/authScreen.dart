import 'package:e_commerce_app/features/auth/services/authService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
// import 'package:chatapp/widgets/user_image_picker.dart';
// import 'package:chat_app/screens/signUpScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  static const String routeName = "/authScreen";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final SignUpformKey = GlobalKey<FormState>();
  final SignInformKey = GlobalKey<FormState>();
  bool haveAccount = true;
  var isUploading = false;
  var savedEmail = '';
  var savedPassword = '';
  var enteredUsername = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void signUpUser(BuildContext) {
    print("sign up methd called");
    authService().signUpUser(
      context: context,
      email: _emailController.text,
      name: _nameController.text,
      password: _passwordController.text,
    );
  }

  void signInUser(BuildContext) {
    print("sign in methd called");
    authService().signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25.sp, 0, 25.sp, 0),
              child: Form(
                key: haveAccount ? SignInformKey : SignUpformKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: haveAccount ? 100.h : 50.h,
                    ),
                    Text(
                      haveAccount ? "Log in" : "Create an account",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: haveAccount ? 40.sp : 35.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    haveAccount
                        ? Text(
                            "Welcome back! Please enter your details.",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey[600],
                            ),
                          )
                        : SizedBox(
                            height: 10.h,
                          ),
                    haveAccount
                        ? SizedBox(
                            height: 25.h,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 15.h),
                                  // child: UserImagePicker(
                                  //     onPickImage: ((pickedImage) {
                                  //   selectedImage = pickedImage;
                                  // })),
                                )
                              ]),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your email address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    if (!haveAccount)
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 4) {
                            return 'Please enter a valid username(atleast 4 words)';
                          }
                          return null;
                        },
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: "Username",
                          hintText: "Enter your Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                      ),
                    if (!haveAccount)
                      SizedBox(
                        height: 20.h,
                      ),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter a valid password!';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    // if (isUploading)
                    //   const Center(child: CircularProgressIndicator()),
                    // if (!isUploading)
                    if (!haveAccount)
                      OutlinedButton(
                        onPressed: () {
                          if (SignUpformKey.currentState!.validate()) {
                            signUpUser(context);
                          }
                        },
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(Size(350.w, 40.h)),
                          shape: MaterialStateProperty.all(
                            const ContinuousRectangleBorder(
                              borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(13),
                              ),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 48, 130, 201),
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    if (haveAccount)
                      OutlinedButton(
                        onPressed: () {
                          if (SignInformKey.currentState!.validate()) {
                            signInUser(context);
                          }
                        },
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(Size(350.w, 40.h)),
                          shape: MaterialStateProperty.all(
                            const ContinuousRectangleBorder(
                              borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(13),
                              ),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 48, 130, 201),
                          ),
                        ),
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: haveAccount ? 30.h : 8.h,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    haveAccount
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    haveAccount = !haveAccount;
                                  });
                                },
                                child: Text(
                                  "Create an account",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color:
                                        const Color.fromARGB(255, 94, 99, 251),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    haveAccount = !haveAccount;
                                  });
                                },
                                child: Text(
                                  "Click to sign in ",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color:
                                        const Color.fromARGB(255, 94, 99, 251),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
