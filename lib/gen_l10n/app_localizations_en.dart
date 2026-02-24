// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'VigilTip';

  @override
  String get homeHeadline => 'Scan a receipt, get tip suggestions';

  @override
  String get homeSubhead =>
      'Based on pre-tax amount, rounded options with a reason for each';

  @override
  String get scanReceipt => 'Scan receipt';

  @override
  String get cameraPermissionDenied =>
      'Camera permission is required to scan receipts';

  @override
  String get noCameraFound => 'No camera found';

  @override
  String get cameraNotSupportedOnPlatform =>
      'Camera is not supported on this platform. Use an Android device to scan receipts.';

  @override
  String cameraInitFailed(String description) {
    return 'Camera failed to start: $description';
  }

  @override
  String captureFailed(String description) {
    return 'Capture failed: $description';
  }

  @override
  String get retry => 'Retry';

  @override
  String get back => 'Back';

  @override
  String get processing => 'Processing...';

  @override
  String get capture => 'Capture';

  @override
  String get pickImageFromGallery => 'Pick from gallery';

  @override
  String get tipSuggestions => 'Tip suggestions';

  @override
  String get recognizingReceipt => 'Recognizing receipt...';

  @override
  String get receiptNotRecognized =>
      'Could not read the receipt. Try again or ensure good lighting.';

  @override
  String get amountNotRecognized =>
      'Could not read amounts. Try again or ensure the receipt is clear.';

  @override
  String get retake => 'Retake';

  @override
  String get backToHome => 'Back to home';

  @override
  String get receiptSummary => 'Receipt summary';

  @override
  String get subtotalPreTax => 'Subtotal (pre-tax)';

  @override
  String get totalNoSubtotal => 'Total (no subtotal found)';

  @override
  String get tax => 'Tax';

  @override
  String get total => 'Total';

  @override
  String get gratuityIncluded => 'Bill already includes tip or service charge';

  @override
  String get tipSuggestionsBasedOnPreTax =>
      'Tip suggestions (based on pre-tax)';

  @override
  String get suggestion => 'No tip needed';

  @override
  String get scanAnotherReceipt => 'Scan another receipt';

  @override
  String get noTipReason =>
      'Bill already includes tip or service charge; no need to add more.';

  @override
  String get tipReasonLow => 'About 5% tip, rounded total';

  @override
  String get tipReasonMedium => 'About 10% tip, rounded total';

  @override
  String get tipReasonHigh => 'About 15% tip, rounded total';

  @override
  String get disclaimerTitle => 'Important Notice';

  @override
  String get disclaimerText =>
      'The following tip suggestions are for reference only. This app assumes no legal liability. Please decide tip amounts based on actual service quality.';

  @override
  String get appMotto => 'Think before you act';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get dataCollection => 'Data Collection';

  @override
  String get dataCollectionContent =>
      'VigilTip only collects the following information when you actively use the app:\n\n• Camera permission: To capture receipt photos\n• Image data: Processed locally, not uploaded to servers\n• Device information: App version and system info (for service improvement)';

  @override
  String get dataUsage => 'Data Usage';

  @override
  String get dataUsageContent =>
      'We use collected data solely for:\n\n• Receipt text recognition (local processing)\n• Tip calculation (local processing)\n• App feature improvement\n• Error diagnosis and fixes';

  @override
  String get dataStorage => 'Data Storage';

  @override
  String get dataStorageContent =>
      '• All image processing is completed locally\n• We do not store your receipt photos\n• No personal data is uploaded to the cloud\n• App settings are saved only on your local device';

  @override
  String get userRights => 'User Rights';

  @override
  String get userRightsContent =>
      'You have the right to:\n\n• Access this privacy policy at any time\n• Deny camera permission (but this affects core functionality)\n• Uninstall the app to delete all local data\n• Contact us with privacy-related questions';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get contactUsContent =>
      'For privacy-related questions, please contact us through:\n\n• Email: privacy@vigiltip.app\n• In-app feedback: Settings page\n\nWe will respond to your inquiries as soon as possible.';

  @override
  String get lastUpdated => 'Last updated: February 2026';

  @override
  String get settings => 'Settings';

  @override
  String get about => 'About';

  @override
  String get aboutApp => 'About App';

  @override
  String get version => 'Version';

  @override
  String get developer => 'Developer';

  @override
  String get appDescription =>
      'VigilTip is an intelligent tip calculator app that automatically recognizes receipt amounts through camera capture and provides three smart tip suggestions.';

  @override
  String get manualInput => 'Manual Input';

  @override
  String get enterBillAmount => 'Enter Bill Amount';

  @override
  String get amount => 'Amount';

  @override
  String get calculateTip => 'Calculate Tip';

  @override
  String get cancel => 'Cancel';

  @override
  String get enterValidAmount => 'Please enter a valid amount';

  @override
  String get algorithmExplanation => 'Algorithm Explanation';

  @override
  String get algorithmOverview => 'Algorithm Overview';

  @override
  String get algorithmOverviewContent =>
      'VigilTip uses a three-tier intelligent tip suggestion system that provides reasonable tip recommendations based on bill amount and service context. The algorithm is based on these principles: fairness, practicality, and cultural adaptability.';

  @override
  String get threeTierSystem => 'Three-Tier Suggestion System';

  @override
  String get threeTierSystemContent =>
      'We provide three different tip suggestion tiers, each suitable for different scenarios and preferences:\n\n• Conservative suggestions: For budget-conscious or average service situations\n• Standard suggestions: For typical restaurant service quality\n• Generous suggestions: For excellent service or special occasions';

  @override
  String get tier1Explanation => 'Tier 1: Conservative Suggestions';

  @override
  String get tier1ExplanationContent =>
      'Goal: Provide economical tip options\n\nFeatures:\n• Typically under 10% rate\n• Prioritizes rounded payments\n• Suitable for small bills (usually under \$40)\n• Considers basic service costs\n\nUse cases:\n• Fast food, coffee shops\n• Average service quality\n• Budget-conscious situations';

  @override
  String get tier2Explanation => 'Tier 2: Standard Suggestions';

  @override
  String get tier2ExplanationContent =>
      'Goal: Provide conventional standard tips\n\nFeatures:\n• Approximately 10% rate\n• Balanced consideration of service quality\n• Suitable for medium bill amounts\n• Uses reasonable rounding strategies\n\nUse cases:\n• Regular restaurant dining\n• Standard service quality\n• Everyday dining situations';

  @override
  String get tier3Explanation => 'Tier 3: Generous Suggestions';

  @override
  String get tier3ExplanationContent =>
      'Goal: Provide tips that recognize excellent service\n\nFeatures:\n• Approximately 15% rate\n• Emphasizes service quality\n• Suitable for higher bill amounts\n• Reflects generous attitude\n\nUse cases:\n• Fine dining restaurants\n• Excellent service experiences\n• Special occasion celebrations';

  @override
  String get roundingRules => 'Rounding Rules';

  @override
  String get roundingRulesContent =>
      'To make tip amounts more practical, we use intelligent rounding strategies:\n\n• Small bills (<\$40): Round to whole numbers\n• Medium bills (\$40-\$100): Round to 5 or 0 endings\n• Large bills (>\$100): Round to 10 or 0 endings\n• Prioritizes ease of payment for total amount\n\nThese rules ensure tip totals are convenient for cash or electronic payments.';

  @override
  String get exampleCalculations => 'Example Calculations';

  @override
  String get exampleCalculationsContent =>
      'Example 1: Bill \$25.50\n• Conservative: \$3.50 (13.8%, rounded to \$29)\n• Standard: \$5.50 (21.6%, rounded to \$31)\n• Generous: \$7.50 (29.4%, rounded to \$33)\n\nExample 2: Bill \$68.25\n• Conservative: \$8.75 (12.8%, rounded to \$77)\n• Standard: \$11.75 (17.2%, rounded to \$80)\n• Generous: \$16.75 (24.6%, rounded to \$85)\n\nExample 3: Bill \$125.00\n• Conservative: \$15.00 (12%, rounded to \$140)\n• Standard: \$25.00 (20%, rounded to \$150)\n• Generous: \$35.00 (28%, rounded to \$160)';

  @override
  String get transparencyCommitment => 'Transparency Commitment';

  @override
  String get transparencyCommitmentContent =>
      'We commit to complete algorithm transparency:\n\n• All calculation logic fully explained\n• No hidden complex rules\n• Welcome user feedback and suggestions\n• Continuously optimize algorithm fairness\n\nWe believe transparency builds user trust and makes every tipping decision more informed.';

  @override
  String get whyTransparent => 'Why Choose Transparency?';

  @override
  String get whyTransparentContent =>
      'In the digital age, algorithm transparency is the foundation of user trust. We disclose our tip calculation logic because:\n\n• You have the right to know where suggestions come from\n• Transparency promotes algorithm fairness\n• Helps you make informed decisions\n• Builds long-term user trust\n\nVigilTip is committed to being your most trusted tip calculation partner.';

  @override
  String get recognizingReceiptContent =>
      'Recognizing receipt content, please wait...';

  @override
  String get viewRawText => 'View Raw Recognized Text';

  @override
  String get rawTextDescription =>
      'Display original text content from OCR recognition';

  @override
  String get backToCamera => 'Back to Camera';

  @override
  String get linesOfText => 'lines of text';

  @override
  String get manualInputAmount => 'Manual Input Amount: \$';

  @override
  String get retakePhoto => 'Retake Photo';

  @override
  String get ocrRecognitionResult => 'OCR Recognition Result:';

  @override
  String get emptyLine => '[Empty Line]';

  @override
  String get billContainsServiceCharge => 'Bill Contains Service Charge';

  @override
  String get serviceChargeAmount => 'Service Charge Amount';

  @override
  String get preTaxPercentage => '% Pre-tax';

  @override
  String get totalPayment => 'Total Payment';

  @override
  String get highTipAmount => 'High Tip Amount';

  @override
  String get highTipWarning =>
      'The lowest tip option exceeds \$20. Please check if the bill amount is correct, or consider manually entering the accurate amount.';
}
