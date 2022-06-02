import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:registeration_screen/widget/forgot_%20password_screen.dart';
import 'package:registeration_screen/widget/home_page.dart';
import 'package:registeration_screen/widget/registeration.dart';
import 'package:registeration_screen/widget/sign_up_screen.dart';
import 'package:registeration_screen/widget/utils.dart';
import 'widget/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'widget/google_signin.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ));
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return Registeration();
            }
          },
        ),
      );
}
