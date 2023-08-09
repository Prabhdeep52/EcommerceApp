import 'dart:convert';

import 'package:e_commerce_app/constants/errorHandling.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/constants/globalVariables.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:e_commerce_app/CommonWidgets/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class authService {
  //SIGN UP USER

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      print("hvhinrf");
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );
      print("egfhioefi");
      http.Response res = await http.post(
        Uri.parse('http://172.20.161.58:3000/api/signup'),
        // Uri.parse('http://localhost:3000/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type':
              'application/json; charset=UTF-8', // Remove unnecessary space
        },
      );

      print(res.body);
      // ignore: use_build_context_synchronously
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () => {
                // showSnackBar(context, "Account created ! ")
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "Account created , Login using same credentials  ")))
              });
    } catch (e) {
      // Catch and handle any exceptions during the HTTP request
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: ${e.toString()}')));
    }
  }

  //SIGN IN USER
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      print("hvhinrf2");

      http.Response res = await http.post(
        Uri.parse('http://172.20.161.58:3000/api/signin'),
        // Uri.parse('http://localhost:3000/api/signup'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type':
              'application/json; charset=UTF-8', // Remove unnecessary space
        },
      );

      print(res.body);
      // ignore: use_build_context_synchronously
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () async {
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            // ignore: use_build_context_synchronously
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      // Catch and handle any exceptions during the HTTP request
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: ${e.toString()}')));
    }
  }

// GET USER DATA
/*
  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('http://172.20.161.58:3000/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token! // Remove unnecessary space
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        //get user data
        http.Response userRes = await http.get(
          Uri.parse('http://172.20.161.58:3000/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token // Remove unnecessary space
          },
        );

        // ignore: use_build_context_synchronously
        var userProvider = Provider.of<UserProvider>(context, listen: true);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      // Catch and handle any exceptions during the HTTP request
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: ${e.toString()}')));
    }
  }
  */

  void getUserData({
    required BuildContext context,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token =
          prefs.getString('x-auth-token') ?? ''; // Default to empty string

      var tokenRes = await http.post(
        Uri.parse('http://172.20.161.58:3000/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('http://172.20.161.58:3000/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        userProvider.setUser(jsonDecode(userRes.body));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
    }
  }
}
