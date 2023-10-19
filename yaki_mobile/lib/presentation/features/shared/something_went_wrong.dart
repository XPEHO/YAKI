import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/styles/text_style.dart';

class FailToFetchDataList extends StatelessWidget {
  const FailToFetchDataList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "😱",
                style: textFetchError(fontSize: 65),
              ),
              const SizedBox(height: 20),
              Text(
                tr('oops'),
                style: textFetchError(fontSize: 30),
              ),
              const SizedBox(height: 10),
              Text(
                tr('somethingWentWrong'),
                style: textFetchError(fontSize: 20),
              ),
              const SizedBox(height: 60),
              Text(
                tr('swipeToRetry'),
                style: textFetchError(fontSize: 15),
              ),
              const Icon(Icons.arrow_drop_down, size: 64, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
