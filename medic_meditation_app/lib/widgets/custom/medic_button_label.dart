import 'package:flutter/material.dart';

class MedicButtonLabel extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback onPressed;
  const MedicButtonLabel(
      {super.key,
      required this.image,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Image.asset(image),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
