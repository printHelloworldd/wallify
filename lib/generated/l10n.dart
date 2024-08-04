// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome To Wallify`
  String get welcomeToWallify {
    return Intl.message(
      'Welcome To Wallify',
      name: 'welcomeToWallify',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match!`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match!',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Wellcome!`
  String get wellcome {
    return Intl.message(
      'Wellcome!',
      name: 'wellcome',
      desc: '',
      args: [],
    );
  }

  /// `Join us and create your account!`
  String get joinUsAndCreateYourAccount {
    return Intl.message(
      'Join us and create your account!',
      name: 'joinUsAndCreateYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message(
      'Full name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Hello Again!`
  String get helloAgain {
    return Intl.message(
      'Hello Again!',
      name: 'helloAgain',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back, you've been missed!`
  String get welcomeBackYouveBeenMissed {
    return Intl.message(
      'Welcome back, you\'ve been missed!',
      name: 'welcomeBackYouveBeenMissed',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Or continue with`
  String get orContinueWith {
    return Intl.message(
      'Or continue with',
      name: 'orContinueWith',
      desc: '',
      args: [],
    );
  }

  /// `Not a member? `
  String get notAMember {
    return Intl.message(
      'Not a member? ',
      name: 'notAMember',
      desc: '',
      args: [],
    );
  }

  /// `Register now`
  String get registerNow {
    return Intl.message(
      'Register now',
      name: 'registerNow',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Wallpapers`
  String get wallpapers {
    return Intl.message(
      'Wallpapers',
      name: 'wallpapers',
      desc: '',
      args: [],
    );
  }

  /// `Nature`
  String get nature {
    return Intl.message(
      'Nature',
      name: 'nature',
      desc: '',
      args: [],
    );
  }

  /// `Cars`
  String get cars {
    return Intl.message(
      'Cars',
      name: 'cars',
      desc: '',
      args: [],
    );
  }

  /// `Film`
  String get film {
    return Intl.message(
      'Film',
      name: 'film',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message(
      'Street',
      name: 'street',
      desc: '',
      args: [],
    );
  }

  /// `Animals`
  String get animals {
    return Intl.message(
      'Animals',
      name: 'animals',
      desc: '',
      args: [],
    );
  }

  /// `Interiors`
  String get interiors {
    return Intl.message(
      'Interiors',
      name: 'interiors',
      desc: '',
      args: [],
    );
  }

  /// `Architecture`
  String get architecture {
    return Intl.message(
      'Architecture',
      name: 'architecture',
      desc: '',
      args: [],
    );
  }

  /// `Downloaded to Gallery!`
  String get downloadedToGallery {
    return Intl.message(
      'Downloaded to Gallery!',
      name: 'downloadedToGallery',
      desc: '',
      args: [],
    );
  }

  /// `Set as wallpaper`
  String get setAsWallpaper {
    return Intl.message(
      'Set as wallpaper',
      name: 'setAsWallpaper',
      desc: '',
      args: [],
    );
  }

  /// `Home screen`
  String get homeScreen {
    return Intl.message(
      'Home screen',
      name: 'homeScreen',
      desc: '',
      args: [],
    );
  }

  /// `Lock screen`
  String get lockScreen {
    return Intl.message(
      'Lock screen',
      name: 'lockScreen',
      desc: '',
      args: [],
    );
  }

  /// `Home and Lock screens`
  String get homeAndLockScreens {
    return Intl.message(
      'Home and Lock screens',
      name: 'homeAndLockScreens',
      desc: '',
      args: [],
    );
  }

  /// `Set`
  String get set {
    return Intl.message(
      'Set',
      name: 'set',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get signOut {
    return Intl.message(
      'Sign out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get noData {
    return Intl.message(
      'No data',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Recommend`
  String get recommend {
    return Intl.message(
      'Recommend',
      name: 'recommend',
      desc: '',
      args: [],
    );
  }

  /// `Rate app`
  String get rateApp {
    return Intl.message(
      'Rate app',
      name: 'rateApp',
      desc: '',
      args: [],
    );
  }

  /// `Send feedback`
  String get sendFeedback {
    return Intl.message(
      'Send feedback',
      name: 'sendFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `System default: English`
  String get systemDefaultLanguage {
    return Intl.message(
      'System default: English',
      name: 'systemDefaultLanguage',
      desc: '',
      args: [],
    );
  }

  /// `App color theme`
  String get appColorTheme {
    return Intl.message(
      'App color theme',
      name: 'appColorTheme',
      desc: '',
      args: [],
    );
  }

  /// `Try another look`
  String get tryAnotherLook {
    return Intl.message(
      'Try another look',
      name: 'tryAnotherLook',
      desc: '',
      args: [],
    );
  }

  /// `Clear search history`
  String get clearSearchHistory {
    return Intl.message(
      'Clear search history',
      name: 'clearSearchHistory',
      desc: '',
      args: [],
    );
  }

  /// `This deletes all of your search history data`
  String get thisDeletesAllOfYourSearchHistoryData {
    return Intl.message(
      'This deletes all of your search history data',
      name: 'thisDeletesAllOfYourSearchHistoryData',
      desc: '',
      args: [],
    );
  }

  /// `Clear cache`
  String get clearCache {
    return Intl.message(
      'Clear cache',
      name: 'clearCache',
      desc: '',
      args: [],
    );
  }

  /// `Reset all settings`
  String get resetAllSettings {
    return Intl.message(
      'Reset all settings',
      name: 'resetAllSettings',
      desc: '',
      args: [],
    );
  }

  /// `Does more than uninstalling would do, \n because the preferences are stored \n at a special place as they have to be \n accessible directly after device startup`
  String get resetAllSettingsDesc {
    return Intl.message(
      'Does more than uninstalling would do, \n because the preferences are stored \n at a special place as they have to be \n accessible directly after device startup',
      name: 'resetAllSettingsDesc',
      desc: '',
      args: [],
    );
  }

  /// `App version`
  String get appVersion {
    return Intl.message(
      'App version',
      name: 'appVersion',
      desc: '',
      args: [],
    );
  }

  /// `System default: {lang}`
  String systemDefaultLang(Object lang) {
    return Intl.message(
      'System default: $lang',
      name: 'systemDefaultLang',
      desc: '',
      args: [lang],
    );
  }

  /// `Cache size: {cacheSize} MB`
  String cacheSize(Object cacheSize) {
    return Intl.message(
      'Cache size: $cacheSize MB',
      name: 'cacheSize',
      desc: '',
      args: [cacheSize],
    );
  }

  /// `My favourites wallpapers`
  String get myFavouritesWallpapers {
    return Intl.message(
      'My favourites wallpapers',
      name: 'myFavouritesWallpapers',
      desc: '',
      args: [],
    );
  }

  /// `No images..`
  String get noImages {
    return Intl.message(
      'No images..',
      name: 'noImages',
      desc: '',
      args: [],
    );
  }

  /// `Select language`
  String get selectLanguage {
    return Intl.message(
      'Select language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Skip for now`
  String get skipForNow {
    return Intl.message(
      'Skip for now',
      name: 'skipForNow',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
