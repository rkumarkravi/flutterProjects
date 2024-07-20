import 'package:flutter/material.dart';
    
class BiggerButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String text;

  const BiggerButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF7C9A92),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }
}