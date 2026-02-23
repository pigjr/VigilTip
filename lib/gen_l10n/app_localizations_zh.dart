// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'VigilTip';

  @override
  String get homeHeadline => '扫描账单，获取小费建议';

  @override
  String get homeSubhead => '基于税前金额，多档取整建议，每档附理由';

  @override
  String get scanReceipt => '扫描账单';

  @override
  String get cameraPermissionDenied => '需要相机权限才能扫描账单';

  @override
  String get noCameraFound => '未找到相机';

  @override
  String get cameraNotSupportedOnPlatform => '当前平台不支持相机，请使用 Android 设备扫描账单。';

  @override
  String cameraInitFailed(String description) {
    return '相机初始化失败: $description';
  }

  @override
  String captureFailed(String description) {
    return '拍照失败: $description';
  }

  @override
  String get retry => '重试';

  @override
  String get back => '返回';

  @override
  String get processing => '处理中...';

  @override
  String get capture => '拍照';

  @override
  String get pickImageFromGallery => '从相册选择';

  @override
  String get tipSuggestions => '小费建议';

  @override
  String get recognizingReceipt => '正在识别账单...';

  @override
  String get receiptNotRecognized => '无法识别账单，请重拍或确保光线充足';

  @override
  String get amountNotRecognized => '无法识别账单金额，请重拍或确保账单清晰';

  @override
  String get retake => '重拍';

  @override
  String get backToHome => '返回首页';

  @override
  String get receiptSummary => '账单摘要';

  @override
  String get subtotalPreTax => '税前小计';

  @override
  String get totalNoSubtotal => '总价（未识别到税前）';

  @override
  String get tax => '税';

  @override
  String get total => '合计';

  @override
  String get gratuityIncluded => '账单已包含小费/服务费';

  @override
  String get tipSuggestionsBasedOnPreTax => '小费建议（基于税前）';

  @override
  String get suggestion => '建议';

  @override
  String get scanAnotherReceipt => '扫描另一张账单';

  @override
  String get noTipReason => '账单已包含小费/服务费，通常无需再付小费';

  @override
  String get tipReasonLow => '约5%小费，凑整支付';

  @override
  String get tipReasonMedium => '约10%小费，凑整支付';

  @override
  String get tipReasonHigh => '约15%小费，凑整支付';

  @override
  String get disclaimerTitle => '重要提示';

  @override
  String get disclaimerText => '以下小费建议仅供参考，本应用不承担任何法律责任。请根据实际服务质量自行决定小费金额。';
}
