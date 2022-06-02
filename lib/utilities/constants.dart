import 'package:flutter/material.dart';

const kDecoration = InputDecoration(
  enabledBorder: UnderlineInputBorder(
    borderSide: const BorderSide(width: 1, color: Colors.blue),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: const BorderSide(width: 1, color: Colors.blue),
  ),
  hintText: '',
);
const kDecorationLogin = InputDecoration(

  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(width: 2, color: Colors.white),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(width: 2, color: Colors.white),
  ),
  hintText: '',
);
