// values are the json object's keys from assets/translations/*.json files
const String remote = 'REMOTE';
const String onSite = 'ON_SITE';
const String vacations = 'VACATION';
const String other = 'OTHER';

final List statusCardsContent = [
  {
    'image': 'assets/images/remote.svg',
    'text': remote,
  },
  {
    'image': 'assets/images/onsite.svg',
    'text': onSite,
  },
  {
    'image': 'assets/images/vacation.svg',
    'text': vacations,
  },
  {
    'image': 'assets/images/dots.svg',
    'text': other,
  },
];

final Map<String, String> statusImage = {
  remote: 'assets/images/remote.svg',
  onSite: 'assets/images/onsite.svg',
  vacations: 'assets/images/vacation.svg',
  other: 'assets/images/dots.svg',
};

final Map<String, String> statusMessage = {
  remote: "StatusRemote",
  onSite: "StatusOnSite",
  vacations: "StatusVacation",
  other: "StatusOther",
};
