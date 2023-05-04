import 'package:flutter/material.dart';
import 'package:yaki/presentation/ui/shared/views/header_declaration.dart';

class PagesLayoutDeclaration extends StatelessWidget {
  final Widget bodyContent;

  final HeaderDeclaration header;

  const PagesLayoutDeclaration({
    super.key,
    required this.header,
    required this.bodyContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header,
            bodyContent,
          ],
        ),
      ),
    );
  }
}
