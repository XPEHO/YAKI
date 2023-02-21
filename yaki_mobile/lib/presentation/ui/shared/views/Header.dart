import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header({Key? key}) : super(key: key);

  final String pictoPath = "assets/images/authent.svg";
  final Widget picto = SvgPicture.asset(
    "assets/images/authent.svg",
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
          color: Colors.amber[400],
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.7),
                spreadRadius: 5,
                blurRadius: 4),
          ]
      ),


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
                      child :SvgPicture.asset('assets/images/authent.svg')
                  ),
                )),
            const Expanded(
                flex: 2,
                child:
                Padding(padding: EdgeInsets.only(top: 40),
                  child: Text('Who are yo ?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Colors.white
                    ),),)
            )
          ],
        ),
      ),
    );
  }
}