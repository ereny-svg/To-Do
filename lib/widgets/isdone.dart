import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IsDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.done,
      style: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(color: AppTheme.green),
    );
  }
}
