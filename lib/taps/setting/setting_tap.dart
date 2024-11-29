import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/taps/setting/language.dart';
import 'package:todo/taps/setting/mode.dart';
import 'package:todo/taps/setting/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingTap extends StatefulWidget {
  const SettingTap({super.key});

  @override
  State<SettingTap> createState() => _SettingTapState();
}

class _SettingTapState extends State<SettingTap> {
  List<Language> languages = [
    Language(name: 'English', code: 'en'),
    Language(name: 'العربية', code: 'ar')
  ];
  List<Mode> mode = [
    Mode(name: 'Light Mode', thememode: ThemeMode.light),
    Mode(name: 'Dark Mode', thememode: ThemeMode.dark)
  ];
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: height * 0.16,
                color: theme.primaryColor,
                width: double.infinity,
              ),
              PositionedDirectional(
                  start: width * 0.1,
                  child: SafeArea(
                    child: Text(
                      AppLocalizations.of(context)!.settings,
                      style: theme.textTheme.bodySmall,
                    ),
                  )),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 38, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: theme.textTheme.titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 17,
                ),
                Container(
                  margin: EdgeInsets.only(left: 18),
                  width: 319,
                  height: 48,
                  decoration: BoxDecoration(
                      color: settingProvider.themeMode == ThemeMode.light
                          ? AppTheme.white
                          : AppTheme.darkblue,
                      border: Border.all(color: AppTheme.primaryLight)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Language>(
                        alignment: AlignmentDirectional.centerEnd,
                        value: languages.firstWhere((language) =>
                            language.code == settingProvider.language),
                        items: languages
                            .map((language) => DropdownMenuItem<Language>(
                                  value: language,
                                  child: Text(
                                    language.name,
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(color: AppTheme.primaryLight),
                                  ),
                                ))
                            .toList(),
                        onChanged: (selectedLanguage) {
                          if (selectedLanguage != null) {
                            settingProvider
                                .changeLanguage(selectedLanguage.code);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: theme.primaryColor,
                        ),
                        isExpanded: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
                Text(
                  AppLocalizations.of(context)!.mode,
                  style: theme.textTheme.titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 17,
                ),
                Container(
                  margin: EdgeInsets.only(left: 18),
                  width: 319,
                  height: 48,
                  decoration: BoxDecoration(
                      color: settingProvider.themeMode == ThemeMode.light
                          ? AppTheme.white
                          : AppTheme.darkblue,
                      border: Border.all(color: AppTheme.primaryLight)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Mode>(
                        alignment: AlignmentDirectional.centerEnd,
                        value: mode.firstWhere((mode) =>
                            mode.thememode == settingProvider.themeMode),
                        items: mode
                            .map((mode) => DropdownMenuItem<Mode>(
                                  value: mode,
                                  child: Text(
                                    mode.name,
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(color: AppTheme.primaryLight),
                                  ),
                                ))
                            .toList(),
                        onChanged: (selectedMode) {
                          if (selectedMode != null) {
                            settingProvider.changeTheme(selectedMode.thememode);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: theme.primaryColor,
                        ),
                        isExpanded: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
