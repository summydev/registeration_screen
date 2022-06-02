import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:registeration_screen/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:registeration_screen/widget/home_page.dart';
import 'package:registeration_screen/widget/utils.dart';
import 'login_screen.dart';
import 'package:provider/provider.dart';
import 'google_signin.dart';

import 'package:shimmer_animation/shimmer_animation.dart';

class SignUp extends StatefulWidget {
  static const String id = 'sign_up';
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(children: [
            Container(
              height: 300.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage("images/pexels-artem-beliaikin-452738.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: kDecoration.copyWith(hintText: 'Name'),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: emailController,
                        decoration: kDecoration.copyWith(
                          hintText: 'Email',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid email'
                                : null,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: kDecoration.copyWith(hintText: 'Password'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6
                            ? 'Enter a min. of 6 characters'
                            : null,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        obscureText: true,
                        controller: confirmPasswordController,
                        onChanged: (value) {
                          setState(() {
                            value != passwordController.text.trim()
                                ? 'password not matching'
                                : null;
                          });
                        },
                        decoration:
                            kDecoration.copyWith(hintText: 'Confirm Password'),
                      ),
                      SizedBox(height: 10.0),
                      Shimmer(
                        child: FlatButton(
                          color: Colors.blue,
                          onPressed: SignUp,
                          child: Text('Sign Up '),
                        ),
                      ),
                      Center(
                        child: Text(
                          '- or -',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Shimmer(
                        child: FlatButton(
                          onPressed: () {
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
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                              ),
                              Text(' Sign up with Google '),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Have an account already?'),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text(
                                ' Sign In',
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      ),
                    ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future SignUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }
}
