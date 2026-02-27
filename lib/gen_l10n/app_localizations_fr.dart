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
  String get cameraNotSupportedOnPlatform =>
      'La caméra n\'est pas prise en charge sur cette plateforme. Utilisez un appareil Android pour scanner les notes.';

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
  String get pickImageFromGallery => 'Choisir depuis la galerie';

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
  String get suggestion => 'Pas de pourboire';

  @override
  String get scanAnotherReceipt => 'Scanner une autre note';

  @override
  String get noTipReason =>
      'La note inclut déjà le pourboire ou le service ; pas besoin d\'ajouter.';

  @override
  String get tipReasonLow => 'Environ 5% de pourboire, total arrondi';

  @override
  String get tipReasonMedium => 'Environ 10% de pourboire, total arrondi';

  @override
  String get tipReasonHigh => 'Environ 15% de pourboire, total arrondi';

  @override
  String get disclaimerTitle => 'Avis Important';

  @override
  String get disclaimerText =>
      'Les suggestions de pourboire suivantes sont à titre de référence uniquement. Cette application n\'assume aucune responsabilité légale. Veuillez décider des montants de pourboire en fonction de la qualité réelle du service.';

  @override
  String get appMotto => 'Pensez avant d\'agir';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get dataCollection => 'Collecte de données';

  @override
  String get dataCollectionContent =>
      'VigilTip ne collecte les informations suivantes que lorsque vous utilisez activement l\'application :\n\n• Autorisation de l\'appareil photo : Pour capturer des photos de reçus\n• Données d\'image : Traitées localement, non téléchargées sur des serveurs\n• Informations sur l\'appareil : Version de l\'application et infos système (pour l\'amélioration du service)';

  @override
  String get dataUsage => 'Utilisation des données';

  @override
  String get dataUsageContent =>
      'Nous utilisons les données collectées uniquement pour :\n\n• Reconnaissance de texte sur les reçus (traitement local)\n• Calcul de pourboire (traitement local)\n• Amélioration des fonctionnalités de l\'application\n• Diagnostic et correction d\'erreurs';

  @override
  String get dataStorage => 'Stockage des données';

  @override
  String get dataStorageContent =>
      '• Tout le traitement d\'image est effectué localement\n• Nous ne stockons pas vos photos de reçus\n• Aucune donnée personnelle n\'est téléchargée sur le cloud\n• Les paramètres de l\'application sont sauvegardés uniquement sur votre appareil local';

  @override
  String get userRights => 'Droits de l\'utilisateur';

  @override
  String get userRightsContent =>
      'Vous avez le droit de :\n\n• Accéder à cette politique de confidentialité à tout moment\n• Refuser l\'autorisation de l\'appareil photo (mais cela affecte les fonctionnalités principales)\n• Désinstaller l\'application pour supprimer toutes les données locales\n• Nous contacter pour des questions relatives à la confidentialité';

  @override
  String get contactUs => 'Nous contacter';

  @override
  String get contactUsContent =>
      'Pour les questions relatives à la confidentialité, veuillez nous contacter par :\n\n• App Store : Contactez via la liste de l\'app store\n• Commentaires dans l\'application : Page des paramètres\n\nNous répondrons à vos demandes dès que possible.';

  @override
  String get lastUpdated => 'Dernière mise à jour : février2026';

  @override
  String get settings => 'Paramètres';

  @override
  String get about => 'À propos';

  @override
  String get aboutApp => 'À propos de l\'application';

  @override
  String get version => 'Version';

  @override
  String get developer => 'Développeur';

  @override
  String get appDescription =>
      'VigilTip est une application de calcul de pourboire intelligente qui reconnaît automatiquement les montants des reçus par capture photo et fournit trois suggestions de pourboire intelligentes.';

  @override
  String get manualInput => 'Saisie Manuelle';

  @override
  String get enterBillAmount => 'Saisir le Montant de la Facture';

  @override
  String get amount => 'Montant';

  @override
  String get calculateTip => 'Calculer le Pourboire';

  @override
  String get cancel => 'Annuler';

  @override
  String get enterValidAmount => 'Veuillez saisir un montant valide';

  @override
  String get algorithmExplanation => 'Explication de l\'Algorithme';

  @override
  String get algorithmOverview => 'Aperçu de l\'Algorithme';

  @override
  String get algorithmOverviewContent =>
      'VigilTip utilise un système de suggestions de pourboire intelligent à trois niveaux qui fournit des recommandations de pourboire raisonnables basées sur le montant de la facture et le contexte du service. L\'algorithme est basé sur ces principes : équité, praticité et adaptabilité culturelle.';

  @override
  String get threeTierSystem => 'Système de Suggestions à Trois Niveaux';

  @override
  String get threeTierSystemContent =>
      'Nous fournissons trois niveaux de suggestions de pourboire différents, chacun adapté à différents scénarios et préférences :\n\n• Suggestions conservatrices : Pour les situations soucieuses du budget ou de service moyen\n• Suggestions standard : Pour la qualité de service typique des restaurants\n• Suggestions généreuses : Pour un service excellent ou des occasions spéciales';

  @override
  String get tier1Explanation => 'Niveau 1 : Suggestions Conservatrices';

  @override
  String get tier1ExplanationContent =>
      'Objectif : Fournir des options de pourboire économiques\n\nCaractéristiques :\n• Taux généralement inférieur à 10%\n• Priorise les paiements arrondis\n• Convient aux petites factures (généralement sous 40\$)\n• Considère les coûts de service de base\n\nCas d\'usage :\n• Fast-food, cafés\n• Qualité de service moyenne\n• Situations soucieuses du budget';

  @override
  String get tier2Explanation => 'Niveau 2 : Suggestions Standard';

  @override
  String get tier2ExplanationContent =>
      'Objectif : Fournir des pourboires standard conventionnels\n\nCaractéristiques :\n• Taux approximatif de 10%\n• Considération équilibrée de la qualité du service\n• Convient aux montants de factures moyens\n• Utilise des stratégies d\'arrondi raisonnables\n\nCas d\'usage :\n• Restaurant standard\n• Qualité de service standard\n• Situations de restauration quotidiennes';

  @override
  String get tier3Explanation => 'Niveau 3 : Suggestions Généreuses';

  @override
  String get tier3ExplanationContent =>
      'Objectif : Fournir des pourboires qui reconnaissent un service excellent\n\nCaractéristiques :\n• Taux approximatif de 15%\n• Met l\'accent sur la qualité du service\n• Convient aux montants de factures plus élevés\n• Reflète une attitude généreuse\n\nCas d\'usage :\n• Restaurants haut de gamme\n• Expériences de service excellentes\n• Célébrations d\'occasions spéciales';

  @override
  String get roundingRules => 'Règles d\'Arrondi';

  @override
  String get roundingRulesContent =>
      'Pour rendre les montants de pourboire plus pratiques, nous utilisons des stratégies d\'arrondi intelligentes :\n\n• Petites factures (<40\$) : Arrondir aux nombres entiers\n• Factures moyennes (40-100\$) : Arrondir aux terminaisons 5 ou 0\n• Grandes factures (>100\$) : Arrondir aux terminaisons 10 ou 0\n• Priorise la facilité de paiement du montant total\n\nCes règles garantissent que les totaux de pourboire sont pratiques pour les paiements en espèces ou électroniques.';

  @override
  String get exampleCalculations => 'Exemples de Calculs';

  @override
  String get exampleCalculationsContent =>
      'Exemple 1 : Facture 25,50\$\n• Conservateur : 3,50\$ (13,8%, arrondi à 29\$)\n• Standard : 5,50\$ (21,6%, arrondi à 31\$)\n• Généreux : 7,50\$ (29,4%, arrondi à 33\$)\n\nExemple 2 : Facture 68,25\$\n• Conservateur : 8,75\$ (12,8%, arrondi à 77\$)\n• Standard : 11,75\$ (17,2%, arrondi à 80\$)\n• Généreux : 16,75\$ (24,6%, arrondi à 85\$)\n\nExemple 3 : Facture 125,00\$\n• Conservateur : 15,00\$ (12%, arrondi à 140\$)\n• Standard : 25,00\$ (20%, arrondi à 150\$)\n• Généreux : 35,00\$ (28%, arrondi à 160\$)';

  @override
  String get transparencyCommitment => 'Engagement de Transparence';

  @override
  String get transparencyCommitmentContent =>
      'Nous nous engageons à une transparence complète de l\'algorithme :\n\n• Toute la logique de calcul pleinement expliquée\n• Aucune règle complexe cachée\n• Bienvenue aux retours et suggestions des utilisateurs\n• Optimisation continue de l\'équité de l\'algorithme\n\nNous croyons que la transparence construit la confiance des utilisateurs et rend chaque décision de pourboire plus éclairée.';

  @override
  String get whyTransparent => 'Pourquoi Choisir la Transparence ?';

  @override
  String get whyTransparentContent =>
      'À l\'ère numérique, la transparence des algorithmes est le fondement de la confiance des utilisateurs. Nous divulguons notre logique de calcul de pourboire parce que :\n\n• Vous avez le droit de savoir d\'où viennent les suggestions\n• La transparence favorise l\'équité des algorithmes\n• Aide à prendre des décisions éclairées\n• Construit la confiance à long terme des utilisateurs\n\nVigilTip s\'engage à être votre partenaire de calcul de pourboire le plus digne de confiance.';

  @override
  String get recognizingReceiptContent =>
      'Reconnaissance du contenu de la facture, veuillez patienter...';

  @override
  String get viewRawText => 'Voir le Texte Brut Reconnu';

  @override
  String get rawTextDescription =>
      'Afficher le contenu textuel original de la reconnaissance OCR';

  @override
  String get backToCamera => 'Retour à l\'Appareil Photo';

  @override
  String get linesOfText => 'lignes de texte';

  @override
  String get manualInputAmount => 'Montant Saisi Manuellement: \$';

  @override
  String get retakePhoto => 'Reprendre Photo';

  @override
  String get ocrRecognitionResult => 'Résultat de la Reconnaissance OCR:';

  @override
  String get emptyLine => '[Ligne Vide]';

  @override
  String get billContainsServiceCharge =>
      'La Facture Contient des Frais de Service';

  @override
  String get serviceChargeAmount => 'Montant des Frais de Service';

  @override
  String get preTaxPercentage => '% Avant Impôt';

  @override
  String get totalPayment => 'Paiement Total';

  @override
  String get highTipAmount => 'Montant de Pourboire Élevé';

  @override
  String get highTipWarning =>
      'L\'option de pourboire la plus basse dépasse 20\$. Veuillez vérifier si le montant de la facture est correct, ou envisagez de saisir manuellement le montant exact.';

  @override
  String get privacyPolicyTitle => 'Politique de Confidentialité';

  @override
  String get privacyPolicyDialogMessage =>
      'Bienvenue dans VigilTip ! Avant d\'utiliser notre application, veuillez lire notre Politique de Confidentialité pour comprendre comment nous protégeons vos données.';

  @override
  String get readPrivacyPolicy => 'Lire la Politique de Confidentialité';

  @override
  String get accept => 'Accepter et Continuer';

  @override
  String get decline => 'Refuser';
}
