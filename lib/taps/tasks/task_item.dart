import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';

class TaskItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      height: 115,
      width: 352,
      decoration: BoxDecoration(
          color: AppTheme.white, borderRadius: BorderRadius.circular(15)),
      child: Row(children: [
        Container(
          height: 62,
          width: 4,
          margin:const EdgeInsetsDirectional.only(end: 25),
          decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.circular(10)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Play Basket Ball',
                style: theme.textTheme.titleMedium!
                    .copyWith(color: theme.primaryColor),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'task description ',
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          width: 69,
          height: 34,
          decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: const Icon(
            Icons.check,
            color: AppTheme.white,
            size: 32,
          ),
        )
      ]),
    );
  }
}
