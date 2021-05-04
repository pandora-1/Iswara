import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iswara/home_page/home_page.dart';
import 'package:iswara/login_page/login_page.dart';
import 'package:iswara/register_page/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'authentication_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Login Register Page",
        home: LoginPage(),
      ),
    );
  }
}
