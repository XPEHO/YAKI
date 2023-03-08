import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yaki/presentation/styles/header_text_style.dart';





class CardTeamMate extends ConsumerWidget {

  ///Card with the Team Mate's avatar, name, update date and status
  const CardTeamMate({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 90,
                  width: 100,
                  child: Stack(
                    children: <Widget>[
                      Material( // Circle with the avatar of the Team Mate
                        shape: const CircleBorder(),
                        child: SvgPicture.asset(
                          'assets/images/avatar1.svg',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Align( // Circle with the status of the Team Mate
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 35),
                          child: Material(
                            elevation: 10,
                            shape: const CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                'assets/images/remote.svg',
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                        // iconPath: 'assets/images/remote.svg',
                        // radius: 40,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text( // Name of the Team Mate
                            'Jean Dupont',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text( // Actualisation Date
                          '16/10/2022 09h40',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.60,
                        child: const Text( // Status of the Team Mate
                          'Remote',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: HeaderColor.yellowApp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}