import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/presentation/extension/extension.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          'assets/lottie/not_found.json',
          height: 180,
        ),
        Text(
          'Data Not Found',
          style: context.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
