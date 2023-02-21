import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Authentification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return the size of the device
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 6,
                child: Header()),
            const Expanded(
                flex: 7,
                child: Text('sdyfg'))
          ],
    ));
  }
}

class Header extends StatelessWidget {
   Header({Key? key}) : super(key: key);

  final String pictoPath = "assets/images/authent.svg";
  final Widget picto = SvgPicture.asset(
      "assets/images/authent.svg",
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[400],
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              flex: 3,
                child: Row(
                  children:  const [
                    Text('Authentification',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    ),
                    Spacer(),
                    CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage:  AssetImage('assets/images/authent.png'),
                        radius: 10,
                        ),
                  ],
            )),

            Expanded(
              flex: 3,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  //backgroundImage: AssetImage('assets/images/authent.png'),
                  radius: 100,
                  child: Container(
                      child : SvgPicture.asset('assets/images/authent.svg')
                  ),
            )),
            const Expanded(
                flex: 2,
                child: Text('dfyg')
            )
          ],
        ),
      ),
    );
  }
}
