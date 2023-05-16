import 'package:flutter/material.dart';

InputDecoration formdecoration({required String hint, String? label}) {
  double rad = 10;
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
    errorStyle: const TextStyle(
        color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10),
    labelText: label,
    labelStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(rad),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: (const BorderSide(width: 1.0, color: Colors.grey)),
      borderRadius: BorderRadius.all(
        Radius.circular(rad),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: (const BorderSide(width: 1.0, color: Colors.blue)),
      borderRadius: BorderRadius.all(
        Radius.circular(rad),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: (const BorderSide(width: 1.0, color: Colors.red)),
      borderRadius: BorderRadius.all(
        Radius.circular(rad),
      ),
    ),
  );
}
