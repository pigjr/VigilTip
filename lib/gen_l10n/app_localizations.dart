import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'VigilTip'**
  String get appTitle;

  /// No description provided for @homeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Scan a receipt, get tip suggestions'**
  String get homeHeadline;

  /// No description provided for @homeSubhead.
  ///
  /// In en, this message translates to:
  /// **'Based on pre-tax amount, rounded options with a reason for each'**
  String get homeSubhead;

  /// No description provided for @scanReceipt.
  ///
  /// In en, this message translates to:
  /// **'Scan receipt'**
  String get scanReceipt;

  /// No description provided for @cameraPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Camera permission is required to scan receipts'**
  String get cameraPermissionDenied;

  /// No description provided for @noCameraFound.
  ///
  /// In en, this message translates to:
  /// **'No camera found'**
  String get noCameraFound;

  /// No description provided for @cameraInitFailed.
  ///
  /// In en, this message translates to:
  /// **'Camera failed to start: {description}'**
  String cameraInitFailed(String description);

  /// No description provided for @captureFailed.
  ///
  /// In en, this message translates to:
  /// **'Capture failed: {description}'**
  String captureFailed(String description);

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @capture.
  ///
  /// In en, this message translates to:
  /// **'Capture'**
  String get capture;

  /// No description provided for @tipSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Tip suggestions'**
  String get tipSuggestions;

  /// No description provided for @recognizingReceipt.
  ///
  /// In en, this message translates to:
  /// **'Recognizing receipt...'**
  String get recognizingReceipt;

  /// No description provided for @receiptNotRecognized.
  ///
  /// In en, this message translates to:
  /// **'Could not read the receipt. Try again or ensure good lighting.'**
  String get receiptNotRecognized;

  /// No description provided for @amountNotRecognized.
  ///
  /// In en, this message translates to:
  /// **'Could not read amounts. Try again or ensure the receipt is clear.'**
  String get amountNotRecognized;

  /// No description provided for @retake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get retake;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;

  /// No description provided for @receiptSummary.
  ///
  /// In en, this message translates to:
  /// **'Receipt summary'**
  String get receiptSummary;

  /// No description provided for @subtotalPreTax.
  ///
  /// In en, this message translates to:
  /// **'Subtotal (pre-tax)'**
  String get subtotalPreTax;

  /// No description provided for @totalNoSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Total (no subtotal found)'**
  String get totalNoSubtotal;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @gratuityIncluded.
  ///
  /// In en, this message translates to:
  /// **'Bill already includes tip or service charge'**
  String get gratuityIncluded;

  /// No description provided for @tipSuggestionsBasedOnPreTax.
  ///
  /// In en, this message translates to:
  /// **'Tip suggestions (based on pre-tax)'**
  String get tipSuggestionsBasedOnPreTax;

  /// No description provided for @suggestion.
  ///
  /// In en, this message translates to:
  /// **'Suggestion'**
  String get suggestion;

  /// No description provided for @scanAnotherReceipt.
  ///
  /// In en, this message translates to:
  /// **'Scan another receipt'**
  String get scanAnotherReceipt;

  /// No description provided for @noTipReason.
  ///
  /// In en, this message translates to:
  /// **'Bill already includes tip or service charge; no need to add more.'**
  String get noTipReason;

  /// No description provided for @tipReason15.
  ///
  /// In en, this message translates to:
  /// **'Standard service, usual tip'**
  String get tipReason15;

  /// No description provided for @tipReason18.
  ///
  /// In en, this message translates to:
  /// **'Good service, slightly above usual'**
  String get tipReason18;

  /// No description provided for @tipReason20.
  ///
  /// In en, this message translates to:
  /// **'Excellent service, thank you'**
  String get tipReason20;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
