import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yaki/presentation/styles/color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryColor,
              AppColors.secondaryColor,
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Opacity(
            opacity: 0.5, // set the opacity value here
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SvgPicture.asset(
                'assets/images/splashscreen.svg',
                height: 100,
                width: 100,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
