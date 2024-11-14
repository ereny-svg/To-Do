import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';

class IsDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Done!',
      style: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(color: AppTheme.green),
    );
  }
}
