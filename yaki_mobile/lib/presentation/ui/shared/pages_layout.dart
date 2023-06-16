import 'package:flutter/material.dart';
import 'package:yaki/presentation/ui/shared/views/header.dart';

class PagesLayout extends StatelessWidget {
  final Widget bodyContent;

  final Header header;

  const PagesLayout({
    super.key,
    required this.header,
    required this.bodyContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: header,
          ),
          Expanded(
            flex: 7,
            child: bodyContent,
          ),
        ],
      ),
    );
  }
}
