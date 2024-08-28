import 'package:flutter/material.dart';
import 'package:flutter_in_store_app_version_checker/flutter_in_store_app_version_checker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/find_locale.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_app_cache_manager/simple_app_cache_manager.dart';
import 'package:wallify/generated/l10n.dart';
import 'package:wallify/profile_page/components/settings_tile.dart';
import 'package:wallify/provider/locale_provider.dart';
import 'package:wallify/theme/theme.dart';
import 'package:wallify/theme/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with CacheMixin {
  final _checker = InStoreAppVersionChecker();
  String currenctAppVersion = "";
  var systemDefaultLocale = "";

  @override
  void initState() {
    super.initState();
    checkVersion();
    findSystemLocale().then((value) {
      switch (value) {
        case "ru_RU":
          value = "русский";
          break;
        case "en_US":
          value = "english";
          break;
        case "en_GB":
          value = "english";
          break;
        default:
      }
      setState(() {
        systemDefaultLocale = value;
      });
    });
  }

  void checkVersion() async {
    _checker.checkUpdate().then((value) {
      // print(value.appURL);         // Return the app url
      // print(value.canUpdate);      // Return true if update is available
      setState(() {
        currenctAppVersion = value.currentVersion;
      });
      print(currenctAppVersion); // Return current app version
      // print(value
      //     .errorMessage); // Return error message if found else it will return null
      // print(value.newVersion); // Return the new app version
    });
  }

  final lightButtonTheme = lightBlueTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightBlueTheme.textTheme;

  var currentLocale = Intl.getCurrentLocale();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeData = Provider.of<ThemeProvider>(context).currentTheme;
    print("Current locale == $currentLocale");

    List<List<dynamic>> settingsTiles = [
      [
        Icons.language,
        S.of(context).language,
        S.of(context).systemDefaultLang(systemDefaultLocale)
      ],
      [
        Icons.palette,
        S.of(context).appColorTheme,
        S.of(context).tryAnotherLook
      ],
      // [
      //   Icons.history,
      //   S.of(context).clearSearchHistory,
      //   S.of(context).thisDeletesAllOfYourSearchHistoryData
      // ],
      [
        const ImageIcon(
          AssetImage("assets/icons/broom.png"),
          size: 24,
        ),
        S.of(context).clearCache,
        S.of(context).cacheSize,
      ],
      // [
      //   Icons.settings_backup_restore,
      //   S.of(context).resetAllSettings,
      //   S.of(context).resetAllSettingsDesc
      // ],
      [
        Icons.system_update,
        S.of(context).appVersion,
        currenctAppVersion,
      ],
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          S.of(context).settings,
          style: TextStyle(
            fontSize: 24,
            color: themeProvider.isDarkMode == true
                ? themeData.primaryColorLight
                : themeData.primaryColorDark,
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: settingsTiles.length,
                  itemBuilder: (context, index) {
                    return SettingsTile(
                      icon: settingsTiles[index][0],
                      title: settingsTiles[index][1],
                      subtitle: settingsTiles[index][2],
                      cacheSizeNotifier: cacheSizeNotifier,
                      clearCache: () {
                        cacheManager.clearCache();
                        updateCacheSize();
                        Fluttertoast.showToast(
                          msg: '😊 ${S.of(context).cacheCleared}',
                          backgroundColor: Colors.green,
                        );
                      },
                      changeLanguage: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.grey[300],
                          builder: (context) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              height: MediaQuery.of(context).size.height / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).selectLanguage,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey[400],
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          // S.load(const Locale('en', 'GB'));
                                          currentLocale = "en";
                                        });
                                        Provider.of<LocaleProvider>(context,
                                                listen: false)
                                            .setLocale(
                                                const Locale('en', 'GB'));
                                        Navigator.pop(context);
                                      },
                                      style: ButtonStyle(
                                        padding:
                                            WidgetStateProperty.all<EdgeInsets>(
                                                EdgeInsets.zero),
                                        shape: WidgetStateProperty.all<
                                            OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        backgroundColor:
                                            WidgetStateColor.resolveWith(
                                          (Set<WidgetState> states) {
                                            if (states.contains(
                                                    WidgetState.hovered) ||
                                                states.contains(
                                                    WidgetState.pressed)) {
                                              return Colors.grey[
                                                  400]!; // Цвет фона при наведении и нажатии
                                            }
                                            return currentLocale == "en_US" ||
                                                    currentLocale ==
                                                        "en_GB" // TODO: Make this with switch statement like findSystemLocale
                                                ? const Color(0xFF004864)
                                                : Colors
                                                    .transparent; // Ис,ходный цвет фона
                                          },
                                        ),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.check_circle_outline,
                                              color: currentLocale == "en_US" ||
                                                      currentLocale == "en_GB"
                                                  ? Colors.white
                                                  : Colors.transparent,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "English",
                                              style: TextStyle(
                                                color: currentLocale ==
                                                            "en_US" ||
                                                        currentLocale == "en_GB"
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          // S.load(const Locale('ru'));
                                          currentLocale = "ru";
                                        });
                                        Provider.of<LocaleProvider>(context,
                                                listen: false)
                                            .setLocale(const Locale('ru'));
                                        Navigator.pop(context);
                                      },
                                      style: ButtonStyle(
                                        padding:
                                            WidgetStateProperty.all<EdgeInsets>(
                                                EdgeInsets.zero),
                                        shape: WidgetStateProperty.all<
                                            OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        backgroundColor:
                                            WidgetStateColor.resolveWith(
                                          (Set<WidgetState> states) {
                                            if (states.contains(
                                                    WidgetState.hovered) ||
                                                states.contains(
                                                    WidgetState.pressed)) {
                                              return Colors.grey[
                                                  400]!; // Цвет фона при наведении и нажатии
                                            }
                                            return currentLocale == "ru_RU"
                                                ? const Color(0xFF004864)
                                                : Colors
                                                    .transparent; // Исходный цвет фона
                                          },
                                        ),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.check_circle_outline,
                                              color: currentLocale == "ru_RU"
                                                  ? Colors.white
                                                  : Colors.transparent,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "Русский",
                                              style: TextStyle(
                                                color: currentLocale == "ru_RU"
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

mixin CacheMixin on State<SettingsPage> {
  late final SimpleAppCacheManager cacheManager;
  late ValueNotifier<String> cacheSizeNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    cacheManager = SimpleAppCacheManager();
    updateCacheSize();
  }

  void updateCacheSize() async {
    final cacheSize = await cacheManager.getTotalCacheSize();
    cacheSizeNotifier.value = cacheSize;
  }
}
