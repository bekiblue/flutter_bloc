import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback? onTap;

  const SignUpButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green, 
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.all(25),
        child: const Center(
          child: Text(
            "Sign Up", // Button text
            style: TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
