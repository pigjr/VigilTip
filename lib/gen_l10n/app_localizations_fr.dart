// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'VigilTip';

  @override
  String get homeHeadline =>
      'Scannez une note, obtenez des suggestions de pourboire';

  @override
  String get homeSubhead =>
      'Sur la base du montant hors taxes, options arrondies avec une raison pour chaque';

  @override
  String get scanReceipt => 'Scanner la note';

  @override
  String get cameraPermissionDenied =>
      'L\'accès à la caméra est nécessaire pour scanner les notes';

  @override
  String get noCameraFound => 'Aucune caméra trouvée';

  @override
  String cameraInitFailed(String description) {
    return 'Échec du démarrage de la caméra : $description';
  }

  @override
  String captureFailed(String description) {
    return 'Échec de la prise : $description';
  }

  @override
  String get retry => 'Réessayer';

  @override
  String get back => 'Retour';

  @override
  String get processing => 'Traitement...';

  @override
  String get capture => 'Prendre';

  @override
  String get tipSuggestions => 'Suggestions de pourboire';

  @override
  String get recognizingReceipt => 'Reconnaissance de la note...';

  @override
  String get receiptNotRecognized =>
      'Impossible de lire la note. Réessayez ou assurez un bon éclairage.';

  @override
  String get amountNotRecognized =>
      'Impossible de lire les montants. Réessayez ou assurez que la note est lisible.';

  @override
  String get retake => 'Reprendre';

  @override
  String get backToHome => 'Retour à l\'accueil';

  @override
  String get receiptSummary => 'Résumé de la note';

  @override
  String get subtotalPreTax => 'Sous-total (hors taxes)';

  @override
  String get totalNoSubtotal => 'Total (sous-total non trouvé)';

  @override
  String get tax => 'Taxes';

  @override
  String get total => 'Total';

  @override
  String get gratuityIncluded =>
      'La note inclut déjà le pourboire ou le service';

  @override
  String get tipSuggestionsBasedOnPreTax =>
      'Suggestions de pourboire (sur base hors taxes)';

  @override
  String get suggestion => 'Suggestion';

  @override
  String get scanAnotherReceipt => 'Scanner une autre note';

  @override
  String get noTipReason =>
      'La note inclut déjà le pourboire ou le service ; pas besoin d\'ajouter.';

  @override
  String get tipReason15 => 'Service standard, pourboire habituel';

  @override
  String get tipReason18 => 'Bon service, un peu au-dessus de l\'habituel';

  @override
  String get tipReason20 => 'Excellent service, merci';
}
