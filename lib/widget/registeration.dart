// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class Registeration extends StatelessWidget {
  const Registeration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer(
        child: Container(
          height: 1000.0,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "images/nature-paradise-landscape-caribbean-maldives.jpg"),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Welcome,',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do  nisi ut aliquip\nex ea commodo consequat!!',
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                RaisedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//We hope you are staying well during this trying time, and we look forward to your arrival tomorrow. Please let us know when you plan to check in and if we can assist you with transportation and luggage. Would you like additional blankets and pillows in your room like your last visit?