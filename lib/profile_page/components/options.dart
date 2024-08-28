// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiredash/wiredash.dart';

import 'package:wallify/generated/l10n.dart';
import 'package:wallify/profile_page/components/custom_text_button.dart';
import 'package:wallify/profile_page/components/policy_dialog.dart';
import 'package:wallify/provider/locale_provider.dart';

class Options extends StatelessWidget {
  final Function() recommendApp;
  final Function() rateApp;
  final ThemeData themeData;

  const Options({
    super.key,
    required this.recommendApp,
    required this.rateApp,
    required this.themeData,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> buttons = [
      S.of(context).settings,
      S.of(context).recommend,
      S.of(context).rateApp,
      S.of(context).sendFeedback,
      S.of(context).privacyPolicy,
    ];
    final List<IconData> buttonIcons = [
      Icons.settings,
      Icons.share,
      Icons.star_border,
      Icons.email,
      Icons.verified_user,
    ];

    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: themeData.dividerColor,
          thickness: 1,
          height: 0,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return CustomTextButton(
          onPressed: () async {
            // Settings
            if (buttons[index] == S.of(context).settings) {
              Navigator.pushNamed(context, "/settings_page");
            }

            // Recommend
            else if (buttons[index] == S.of(context).recommend) {
              recommendApp();
            }

            // Rate app
            else if (buttons[index] == S.of(context).rateApp) {
              rateApp();
            }

            // Send feedback
            else if (buttons[index] == S.of(context).sendFeedback) {
              Wiredash.of(context).show(inheritMaterialTheme: true);
            }

            // Privacy policy
            else if (buttons[index] == S.of(context).privacyPolicy) {
              showDialog(
                context: context,
                builder: (context) {
                  return PolicyDialog(
                    mdFileName:
                        Provider.of<LocaleProvider>(context, listen: false)
                                    .locale ==
                                const Locale("ru")
                            ? "privacy_policy_ru.md"
                            : "privacy_policy.md",
                  );
                },
              );
            }
          },
          text: buttons[index],
          icon: buttonIcons[index],
        );
      },
    );
  }
}
