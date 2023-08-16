import 'package:yaki/presentation/displaydata/status_page_utils.dart';

// list used in declaration body to map and create status card.
// use enum.values.name to directly have access to the translation key.
final List statusCardsContent = [
  {
    'image': 'assets/images/remote.svg',
    'text': StatusEnum.remote.name,
  },
  {
    'image': 'assets/images/onSite.svg',
    'text': StatusEnum.onSite.name,
  },
  {
    'image': 'assets/images/vacation.svg',
    'text': StatusEnum.vacation.name,
  },
];
