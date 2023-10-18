import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              Color(0xFFFF936B),
              Color(0xFFFF7746),
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
