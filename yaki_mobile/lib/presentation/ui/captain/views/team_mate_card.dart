import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yaki/presentation/displaydata/status_page_content.dart';
import 'package:yaki/presentation/styles/header_text_style.dart';

class CardTeamMate extends StatefulWidget {
  /// Card with the Team Mate's avatar, name, update date and status
  const CardTeamMate({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.status,
    required this.dateActu,
  });

  final String? firstName;
  final String? lastName;
  final String? status;
  final DateTime? dateActu;

  @override
  State<CardTeamMate> createState() => _CardTeamMateState();
}

class _CardTeamMateState extends State<CardTeamMate> {
  @override
  Widget build(BuildContext context) {
    // recovers device dimensions
    var size = MediaQuery.of(context).size;

    // Format Date.nom
    // var dateDec = DateFormat('dd/MM/yyyy HH:mm')
    //     .format(widget.dateActu ?? DateTime.now());

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
                      Material(
                        // Circle with the avatar of the Team Mate
                        shape: const CircleBorder(),
                        child: SvgPicture.asset(
                          'assets/images/avatar1.svg',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Align(
                        // Circle with the status of the Team Mate
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 35),
                          child: Material(
                            elevation: 10,
                            shape: const CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                StatusUtils.getImage(widget.status ?? ""),
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        ),
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
                        children: [
                          Text(
                            // Name of the Team Mate
                            '${widget.firstName} ${widget.lastName}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          // Actualisation Date
                          widget.dateActu != null
                              ? DateFormat('dd/MM/yyyy HH:mm')
                                  .format(widget.dateActu!)
                              : '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.60,
                        child: Text(
                          // Status of the Team Mate
                          widget.status ?? 'Undeclared',
                          textAlign: TextAlign.end,
                          style: const TextStyle(
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
