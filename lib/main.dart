// import 'package:chatapp/firebase_options.dart';
// import 'package:chatapp/screens/authScreen.dart';
// import 'package:chatapp/screens/chatScreen.dart';
// import 'package:chatapp/screens/waiting.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:js';

import 'package:e_commerce_app/CommonWidgets/bottomBar.dart';
import 'package:e_commerce_app/features/auth/screens/authScreen.dart';
import 'package:e_commerce_app/features/home/homeScreen.dart';
import './features/auth/services/authService.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'package:e_commerce_app/features/admin/screens/adminScreen.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:e_commerce_app/router.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
// import 'package:firebase_core/firebase_core.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authService authservice = authService();
  @override
  void initState() {
    super.initState();
    authservice.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              // key: scaffoldMessengerKey,
              home: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            // You can use the library anywhere in the app even in theme
            theme: ThemeData().copyWith(
              useMaterial3: true,
              // brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromARGB(255, 63, 17, 177)),
              // scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
            ),
            onGenerateRoute: (settings) => generateRoute(settings),
            // home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            //     ? Provider.of<UserProvider>(context).user.type == 'user'
            //         ? const BottomAppBar()
            //         : const AdminScreen()
            //     : const AuthScreen(),
            home: AdminScreen(),
            // home: Consumer<UserProvider>(
            //   builder: (context, userProvider, child)  {
            //     Provider.of<UserProvider>(context).user.token.isNotEmpty
            //         ? Provider.of<UserProvider>(context).user.type == 'user'
            //             ? const BottomAppBar()
            //             : const AdminScreen()
            //         : const AuthScreen();
            //   },
            // ),
          ));
        });
  }
}
