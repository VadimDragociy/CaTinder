import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final VoidCallback onPressed;
  const LikeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Image.asset('assets/heart-24.png'),
    );
  }
}

class DislikeButton extends StatelessWidget {
  final VoidCallback onPressed;
  const DislikeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Image.asset('assets/cross-24.png'),
    );
  }
}
