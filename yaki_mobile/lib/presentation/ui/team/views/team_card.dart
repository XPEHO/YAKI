import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardTeam extends StatefulWidget {
  /// Card with the Team's id, name
  const CardTeam({
    super.key,
    required this.teamId,
    required this.teamName,
  });

  final int? teamId;
  final String? teamName;

  @override
  State<CardTeam> createState() => _CardTeamState();
}

class _CardTeamState extends State<CardTeam> {
  @override
  Widget build(BuildContext context) {
    // recovers device dimensions
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
                      Material(
                        // Circle with the avatar of the Team Mate
                        shape: const CircleBorder(),
                        child: SvgPicture.asset(
                          'assets/images/avatar1.svg',
                          width: 80,
                          height: 80,
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
                            '${widget.teamId} ${widget.teamName}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
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
