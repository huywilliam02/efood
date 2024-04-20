import 'package:flutter/material.dart';

class CommonLoadingPageProgressIndicator extends StatelessWidget {
  const CommonLoadingPageProgressIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator(
          strokeWidth: 5,
          color: Colors.greenAccent,
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}
