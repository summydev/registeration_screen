import 'package:flutter/material.dart';
import 'package:registeration_screen/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:registeration_screen/widget/forgot_%20password_screen.dart';
import 'package:registeration_screen/widget/home_page.dart';
import 'package:registeration_screen/widget/sign_up_screen.dart';
import 'package:registeration_screen/widget/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'google_signin.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Container(
            height: 1000.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/pexels-pixabay-413960.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Enjoy your vacation\nthis summer',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 40.0),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text('see & book you favourite hotels',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold))
                        ]),
                    SizedBox(height: 25.0),
                    FlatButton(
                      height: 45.0,
                      onPressed: ()  {
                        try {
                          final provider =
                               Provider.of<GoogleSignInProvider>(context,
                                  listen: false);
                          provider.googleLogin();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        } catch (e) {
                          print(e);
                          Utils.showSnackBar(e.toString());
                        }
                      },
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.red,
                          ),
                          Text(' Sign In With Google'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Center(
                        child: Text(
                          '-or sign in with email and password-',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: emailController,
                      decoration: kDecorationLogin.copyWith(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid email'
                              : null,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      controller: passwordController,
                      decoration: kDecorationLogin.copyWith(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 6
                          ? 'Enter a min. of 6 characters'
                          : null,
                    ),
                    SizedBox(height: 0.5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FlatButton(
                      height: 45.0,
                      color: Colors.white,
                      onPressed: LogIn,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: Text('Log In '),
                    ),
                    Row(
                      children: [
                        Text(
                          'Not registered yet?',
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text(
                              'Create an account',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future LogIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Utils.showSnackBar(e.message);
    }
  }
}
