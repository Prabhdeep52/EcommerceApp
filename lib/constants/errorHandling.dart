import 'dart:convert';

import 'package:e_commerce_app/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandling({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  try {
    switch (response.statusCode) {
      case 200:
        onSuccess();
        break;
      case 400:
        print("400");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonDecode(response.body)['msg'])));
        break;
      case 500:
        print("500");
        // Assume the response body contains JSON data
        final responseData = jsonDecode(response.body);
        final errorMsg =
            responseData['msg'] as String? ?? 'Unknown error occured';
        print(errorMsg);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMsg)));
        break;
      default:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response.body)));
      // showSnackBar(context, 'Unexpected status code: ${response.statusCode}');
    }
  } catch (e) {
    // Error parsing the response body as JSON
    print("a");
    print(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')));
  }
}
