import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';

class LocationCardContent {
  final List<String> imageSrc;
  final List<String> title;
  final List<StatusEnum> subtitle;

  LocationCardContent({
    required this.imageSrc,
    required this.title,
    required this.subtitle,
  });
}
