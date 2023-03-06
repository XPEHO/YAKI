import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.statusPicto,
    required this.statusName,
    required this.getClick,
  });

  final String statusName;
  final String statusPicto;
  final VoidCallback getClick;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return width < 670
        ? SizedBox(
            width: MediaQuery.of(context).size.width * 0.37,
            height: MediaQuery.of(context).size.width * 0.37,
            child: SizeBoxChild(
              statusName: statusName,
              statusPicto: statusPicto,
              getClick: getClick,
            ),
          )
        : ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 250,
              maxHeight: 250,
            ),
            child: SizeBoxChild(
              statusName: statusName,
              statusPicto: statusPicto,
              getClick: getClick,
            ),
          );
  }
}

class SizeBoxChild extends StatelessWidget {
  const SizeBoxChild({
    super.key,
    required this.statusName,
    required this.statusPicto,
    required this.getClick,
  });

  final String statusPicto;
  final String statusName;
  final VoidCallback getClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: getClick,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        foregroundColor: Colors.amber.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.55,
              heightFactor: 0.55,
              alignment: FractionalOffset.center,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SvgPicture.asset(statusPicto),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                statusName,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
