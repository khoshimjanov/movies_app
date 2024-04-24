import 'package:flutter/material.dart';
import 'package:movies_app/helpers/app_styles.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Something went wrong',
        style: AppStyles.movieTypeTextStyle,
      ),
    );
  }
}
