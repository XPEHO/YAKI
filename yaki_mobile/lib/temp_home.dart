import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TempHome extends StatelessWidget {
  const TempHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('temp routing page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            ButtonRoute(
              btnText: 'authentication page',
              route: '/authentication',
            ),
            ButtonRoute(
              btnText: 'Delcaration page',
              route: '/declaration',
            ),
            ButtonRoute(
              btnText: 'Status page',
              route: '/status',
            ),
            ButtonRoute(
              btnText: 'Captain page',
              route: '/captain',
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonRoute extends StatelessWidget {
  final String route;
  final String btnText;

  const ButtonRoute({super.key, required this.btnText, required this.route});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 70),
      ),
      onPressed: () => context.go(route),
      child: Text(
        btnText,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
