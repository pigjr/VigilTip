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

  /// No description provided for @cameraNotSupportedOnPlatform.
  ///
  /// In en, this message translates to:
  /// **'Camera is not supported on this platform. Use an Android device to scan receipts.'**
  String get cameraNotSupportedOnPlatform;

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

  /// No description provided for @pickImageFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Pick from gallery'**
  String get pickImageFromGallery;

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
  /// **'No tip needed'**
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

  /// No description provided for @tipReasonLow.
  ///
  /// In en, this message translates to:
  /// **'About 5% tip, rounded total'**
  String get tipReasonLow;

  /// No description provided for @tipReasonMedium.
  ///
  /// In en, this message translates to:
  /// **'About 10% tip, rounded total'**
  String get tipReasonMedium;

  /// No description provided for @tipReasonHigh.
  ///
  /// In en, this message translates to:
  /// **'About 15% tip, rounded total'**
  String get tipReasonHigh;

  /// No description provided for @disclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Important Notice'**
  String get disclaimerTitle;

  /// No description provided for @disclaimerText.
  ///
  /// In en, this message translates to:
  /// **'The following tip suggestions are for reference only. This app assumes no legal liability. Please decide tip amounts based on actual service quality.'**
  String get disclaimerText;

  /// No description provided for @appMotto.
  ///
  /// In en, this message translates to:
  /// **'Think before you act'**
  String get appMotto;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @dataCollection.
  ///
  /// In en, this message translates to:
  /// **'Data Collection'**
  String get dataCollection;

  /// No description provided for @dataCollectionContent.
  ///
  /// In en, this message translates to:
  /// **'VigilTip only collects the following information when you actively use the app:\n\n• Camera permission: To capture receipt photos\n• Image data: Processed locally, not uploaded to servers\n• Device information: App version and system info (for service improvement)'**
  String get dataCollectionContent;

  /// No description provided for @dataUsage.
  ///
  /// In en, this message translates to:
  /// **'Data Usage'**
  String get dataUsage;

  /// No description provided for @dataUsageContent.
  ///
  /// In en, this message translates to:
  /// **'We use collected data solely for:\n\n• Receipt text recognition (local processing)\n• Tip calculation (local processing)\n• App feature improvement\n• Error diagnosis and fixes'**
  String get dataUsageContent;

  /// No description provided for @dataStorage.
  ///
  /// In en, this message translates to:
  /// **'Data Storage'**
  String get dataStorage;

  /// No description provided for @dataStorageContent.
  ///
  /// In en, this message translates to:
  /// **'• All image processing is completed locally\n• We do not store your receipt photos\n• No personal data is uploaded to the cloud\n• App settings are saved only on your local device'**
  String get dataStorageContent;

  /// No description provided for @userRights.
  ///
  /// In en, this message translates to:
  /// **'User Rights'**
  String get userRights;

  /// No description provided for @userRightsContent.
  ///
  /// In en, this message translates to:
  /// **'You have the right to:\n\n• Access this privacy policy at any time\n• Deny camera permission (but this affects core functionality)\n• Uninstall the app to delete all local data\n• Contact us with privacy-related questions'**
  String get userRightsContent;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @contactUsContent.
  ///
  /// In en, this message translates to:
  /// **'For privacy-related questions, please contact us through:\n\n• Email: privacy@vigiltip.app\n• In-app feedback: Settings page\n\nWe will respond to your inquiries as soon as possible.'**
  String get contactUsContent;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: February 2026'**
  String get lastUpdated;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'VigilTip is an intelligent tip calculator app that automatically recognizes receipt amounts through camera capture and provides three smart tip suggestions.'**
  String get appDescription;

  /// No description provided for @manualInput.
  ///
  /// In en, this message translates to:
  /// **'Manual Input'**
  String get manualInput;

  /// No description provided for @enterBillAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Bill Amount'**
  String get enterBillAmount;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @calculateTip.
  ///
  /// In en, this message translates to:
  /// **'Calculate Tip'**
  String get calculateTip;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @enterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get enterValidAmount;

  /// No description provided for @algorithmExplanation.
  ///
  /// In en, this message translates to:
  /// **'Algorithm Explanation'**
  String get algorithmExplanation;

  /// No description provided for @algorithmOverview.
  ///
  /// In en, this message translates to:
  /// **'Algorithm Overview'**
  String get algorithmOverview;

  /// No description provided for @algorithmOverviewContent.
  ///
  /// In en, this message translates to:
  /// **'VigilTip uses a three-tier intelligent tip suggestion system that provides reasonable tip recommendations based on bill amount and service context. The algorithm is based on these principles: fairness, practicality, and cultural adaptability.'**
  String get algorithmOverviewContent;

  /// No description provided for @threeTierSystem.
  ///
  /// In en, this message translates to:
  /// **'Three-Tier Suggestion System'**
  String get threeTierSystem;

  /// No description provided for @threeTierSystemContent.
  ///
  /// In en, this message translates to:
  /// **'We provide three different tip suggestion tiers, each suitable for different scenarios and preferences:\n\n• Conservative suggestions: For budget-conscious or average service situations\n• Standard suggestions: For typical restaurant service quality\n• Generous suggestions: For excellent service or special occasions'**
  String get threeTierSystemContent;

  /// No description provided for @tier1Explanation.
  ///
  /// In en, this message translates to:
  /// **'Tier 1: Conservative Suggestions'**
  String get tier1Explanation;

  /// No description provided for @tier1ExplanationContent.
  ///
  /// In en, this message translates to:
  /// **'Goal: Provide economical tip options\n\nFeatures:\n• Typically under 10% rate\n• Prioritizes rounded payments\n• Suitable for small bills (usually under \$40)\n• Considers basic service costs\n\nUse cases:\n• Fast food, coffee shops\n• Average service quality\n• Budget-conscious situations'**
  String get tier1ExplanationContent;

  /// No description provided for @tier2Explanation.
  ///
  /// In en, this message translates to:
  /// **'Tier 2: Standard Suggestions'**
  String get tier2Explanation;

  /// No description provided for @tier2ExplanationContent.
  ///
  /// In en, this message translates to:
  /// **'Goal: Provide conventional standard tips\n\nFeatures:\n• Approximately 10% rate\n• Balanced consideration of service quality\n• Suitable for medium bill amounts\n• Uses reasonable rounding strategies\n\nUse cases:\n• Regular restaurant dining\n• Standard service quality\n• Everyday dining situations'**
  String get tier2ExplanationContent;

  /// No description provided for @tier3Explanation.
  ///
  /// In en, this message translates to:
  /// **'Tier 3: Generous Suggestions'**
  String get tier3Explanation;

  /// No description provided for @tier3ExplanationContent.
  ///
  /// In en, this message translates to:
  /// **'Goal: Provide tips that recognize excellent service\n\nFeatures:\n• Approximately 15% rate\n• Emphasizes service quality\n• Suitable for higher bill amounts\n• Reflects generous attitude\n\nUse cases:\n• Fine dining restaurants\n• Excellent service experiences\n• Special occasion celebrations'**
  String get tier3ExplanationContent;

  /// No description provided for @roundingRules.
  ///
  /// In en, this message translates to:
  /// **'Rounding Rules'**
  String get roundingRules;

  /// No description provided for @roundingRulesContent.
  ///
  /// In en, this message translates to:
  /// **'To make tip amounts more practical, we use intelligent rounding strategies:\n\n• Small bills (<\$40): Round to whole numbers\n• Medium bills (\$40-\$100): Round to 5 or 0 endings\n• Large bills (>\$100): Round to 10 or 0 endings\n• Prioritizes ease of payment for total amount\n\nThese rules ensure tip totals are convenient for cash or electronic payments.'**
  String get roundingRulesContent;

  /// No description provided for @exampleCalculations.
  ///
  /// In en, this message translates to:
  /// **'Example Calculations'**
  String get exampleCalculations;

  /// No description provided for @exampleCalculationsContent.
  ///
  /// In en, this message translates to:
  /// **'Example 1: Bill \$25.50\n• Conservative: \$3.50 (13.8%, rounded to \$29)\n• Standard: \$5.50 (21.6%, rounded to \$31)\n• Generous: \$7.50 (29.4%, rounded to \$33)\n\nExample 2: Bill \$68.25\n• Conservative: \$8.75 (12.8%, rounded to \$77)\n• Standard: \$11.75 (17.2%, rounded to \$80)\n• Generous: \$16.75 (24.6%, rounded to \$85)\n\nExample 3: Bill \$125.00\n• Conservative: \$15.00 (12%, rounded to \$140)\n• Standard: \$25.00 (20%, rounded to \$150)\n• Generous: \$35.00 (28%, rounded to \$160)'**
  String get exampleCalculationsContent;

  /// No description provided for @transparencyCommitment.
  ///
  /// In en, this message translates to:
  /// **'Transparency Commitment'**
  String get transparencyCommitment;

  /// No description provided for @transparencyCommitmentContent.
  ///
  /// In en, this message translates to:
  /// **'We commit to complete algorithm transparency:\n\n• All calculation logic fully explained\n• No hidden complex rules\n• Welcome user feedback and suggestions\n• Continuously optimize algorithm fairness\n\nWe believe transparency builds user trust and makes every tipping decision more informed.'**
  String get transparencyCommitmentContent;

  /// No description provided for @whyTransparent.
  ///
  /// In en, this message translates to:
  /// **'Why Choose Transparency?'**
  String get whyTransparent;

  /// No description provided for @whyTransparentContent.
  ///
  /// In en, this message translates to:
  /// **'In the digital age, algorithm transparency is the foundation of user trust. We disclose our tip calculation logic because:\n\n• You have the right to know where suggestions come from\n• Transparency promotes algorithm fairness\n• Helps you make informed decisions\n• Builds long-term user trust\n\nVigilTip is committed to being your most trusted tip calculation partner.'**
  String get whyTransparentContent;

  /// No description provided for @recognizingReceiptContent.
  ///
  /// In en, this message translates to:
  /// **'Recognizing receipt content, please wait...'**
  String get recognizingReceiptContent;

  /// No description provided for @viewRawText.
  ///
  /// In en, this message translates to:
  /// **'View Raw Recognized Text'**
  String get viewRawText;

  /// No description provided for @rawTextDescription.
  ///
  /// In en, this message translates to:
  /// **'Display original text content from OCR recognition'**
  String get rawTextDescription;

  /// No description provided for @backToCamera.
  ///
  /// In en, this message translates to:
  /// **'Back to Camera'**
  String get backToCamera;

  /// No description provided for @linesOfText.
  ///
  /// In en, this message translates to:
  /// **'lines of text'**
  String get linesOfText;

  /// No description provided for @manualInputAmount.
  ///
  /// In en, this message translates to:
  /// **'Manual Input Amount: \$'**
  String get manualInputAmount;

  /// No description provided for @retakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Retake Photo'**
  String get retakePhoto;

  /// No description provided for @ocrRecognitionResult.
  ///
  /// In en, this message translates to:
  /// **'OCR Recognition Result:'**
  String get ocrRecognitionResult;

  /// No description provided for @emptyLine.
  ///
  /// In en, this message translates to:
  /// **'[Empty Line]'**
  String get emptyLine;

  /// No description provided for @billContainsServiceCharge.
  ///
  /// In en, this message translates to:
  /// **'Bill Contains Service Charge'**
  String get billContainsServiceCharge;

  /// No description provided for @serviceChargeAmount.
  ///
  /// In en, this message translates to:
  /// **'Service Charge Amount'**
  String get serviceChargeAmount;

  /// No description provided for @preTaxPercentage.
  ///
  /// In en, this message translates to:
  /// **'% Pre-tax'**
  String get preTaxPercentage;

  /// No description provided for @totalPayment.
  ///
  /// In en, this message translates to:
  /// **'Total Payment'**
  String get totalPayment;

  /// No description provided for @highTipAmount.
  ///
  /// In en, this message translates to:
  /// **'High Tip Amount'**
  String get highTipAmount;

  /// No description provided for @highTipWarning.
  ///
  /// In en, this message translates to:
  /// **'The lowest tip option exceeds \$20. Please check if the bill amount is correct, or consider manually entering the accurate amount.'**
  String get highTipWarning;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @privacyPolicyDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to VigilTip! Before using our app, please read our Privacy Policy to understand how we protect your data.'**
  String get privacyPolicyDialogMessage;

  /// No description provided for @readPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Read Privacy Policy'**
  String get readPrivacyPolicy;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept & Continue'**
  String get accept;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;
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
