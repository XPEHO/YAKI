import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/displaydata/declaration_summary_enum.dart';
import 'package:yaki/presentation/features/declaration_summary/view/summary_absence.dart';
import 'package:yaki/presentation/features/declaration_summary/view/summary_chips_duo.dart';
import 'package:yaki/presentation/features/declaration_summary/view/summary_half_day.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki_ui/yaki_ui.dart';

class DeclarationSummary extends ConsumerWidget {
  final String summaryMode;

  const DeclarationSummary({
    super.key,
    required this.summaryMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(88),
                  child: SvgPicture.asset(
                    'assets/images/Validated.svg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  tr('entryValidated'),
                  style: textStylePageTitle(),
                ),
                const SizedBox(height: 8),
                Text(
                  tr('youCanCloseTheApp'),
                  style: textStyleSummarySubtitle(),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: setSummaryWidget(ref: ref, summaryMode: summaryMode),
                  ),
                ),
                Button(
                  text: tr("modify"),
                  onPressed: () {
                    ref.read(teamProvider.notifier).clearTeamList();
                    context.go("/team-selection");
                  },
                  color: const Color(0xFF37414C),
                ),
                const SizedBox(height: 8),
                Button.secondary(
                  text: tr("seeTeam"),
                  onPressed: () => {},
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget setSummaryWidget({
  required String summaryMode,
  required WidgetRef ref,
}) {
  DeclarationStatus declarationStatus = ref.read(declarationProvider);

  if (summaryMode == DeclarationSummaryPaths.fullDay.text) {
    return SummaryChipDuo(
      status: declarationStatus.fullDayStatus,
      team: declarationStatus.fullDayTeam,
    );
  } else if (summaryMode == DeclarationSummaryPaths.halfDay.text) {
    return SummaryHalfDay(
      halfDayData: declarationStatus.declarationsHalfDaySelections,
    );
  } else {
    return SummaryAbsence(
      dateStart: declarationStatus.dateAbsenceStart,
      dateEnd: declarationStatus.dateAbsenceEnd,
    );
  }
}
