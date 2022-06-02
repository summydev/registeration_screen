import 'package:flutter/material.dart';
import 'package:registeration_screen/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:registeration_screen/widget/utils.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'forgot_password';
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Input your email to\nreset your password',
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(
              height: 30.0,
            ),
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
            RaisedButton(
              color: Colors.blue,
              onPressed: ForgotPassword,
              child: Text('Send email '),
            ),
          ],
        ),
      ),
    );
  }

  Future ForgotPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('Password reset email sent');
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Utils.showSnackBar(e.message);
    }
  }
}
