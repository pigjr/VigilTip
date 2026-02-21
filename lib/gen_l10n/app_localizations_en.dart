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
  String get suggestion => 'Suggestion';

  @override
  String get scanAnotherReceipt => 'Scan another receipt';

  @override
  String get noTipReason =>
      'Bill already includes tip or service charge; no need to add more.';

  @override
  String get tipReason15 => 'Standard service, usual tip';

  @override
  String get tipReason18 => 'Good service, slightly above usual';

  @override
  String get tipReason20 => 'Excellent service, thank you';
}
