import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import 'features/auth/screens/authScreen.dart';
import 'features/auth/services/authService.dart';
import 'features/home/homeScreen.dart';

class InitState extends StatefulWidget {
  const InitState({super.key});

  @override
  State<InitState> createState() => _InitStateState();
}

class _InitStateState extends State<InitState> {
  final authService authservice = authService();

  @override
  void initState() {
    super.initState();
    authservice.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        body: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? const HomeScreen()
            : const AuthScreen(),
      ),
    );
  }
}
