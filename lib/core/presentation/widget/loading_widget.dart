import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../extension/extension.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height / 2,
      width: context.width,
      child: Center(
        child: LottieBuilder.asset(
          'assets/lottie/loading.json',
          height: 100,
        ),
      ),
    );
  }
}
