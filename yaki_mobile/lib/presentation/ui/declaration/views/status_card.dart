import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatusCard extends StatelessWidget {
  final String statusPicto;
  final String statusName;
  final VoidCallback onPress;

  const StatusCard({
    super.key,
    required this.statusName,
    required this.statusPicto,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        if (constraint.maxWidth < 350) {
          return SmallStatusButton(
            statusPicto: statusPicto,
            statusName: statusName,
            onPress: onPress,
          );
        } else {
          return BigStatusButton(
            statusPicto: statusPicto,
            statusName: statusName,
            onPress: onPress,
          );
        }
      },
    );
  }
}

class SmallStatusButton extends StatelessWidget {
  final String statusPicto;
  final String statusName;
  final VoidCallback onPress;

  const SmallStatusButton({
    super.key,
    required this.statusPicto,
    required this.statusName,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: ElevatedButton(
        onPressed: onPress,
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
      ),
    );
  }
}

class BigStatusButton extends StatelessWidget {
  final String statusPicto;
  final String statusName;
  final VoidCallback onPress;

  const BigStatusButton({
    super.key,
    required this.statusPicto,
    required this.statusName,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 160,
      child: ElevatedButton(
        onPressed: onPress,
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
      ),
    );
  }
}
