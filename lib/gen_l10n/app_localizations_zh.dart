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
  String get suggestion => '无需小费';

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

  @override
  String get appMotto => '三思而后行';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get dataCollection => '数据收集';

  @override
  String get dataCollectionContent =>
      'VigilTip仅在您主动使用时收集以下信息：\n\n• 相机权限：用于拍摄收据照片\n• 图片数据：仅在本地处理，不上传到服务器\n• 设备信息：应用版本和系统信息（用于改进服务）';

  @override
  String get dataUsage => '数据使用';

  @override
  String get dataUsageContent =>
      '我们收集的数据仅用于：\n\n• 收据文字识别（本地处理）\n• 小费计算（本地处理）\n• 应用功能改进\n• 错误诊断和修复';

  @override
  String get dataStorage => '数据存储';

  @override
  String get dataStorageContent =>
      '• 所有图片处理均在本地完成\n• 我们不会存储您的收据照片\n• 不会将个人数据上传到云端\n• 应用设置仅保存在本地设备';

  @override
  String get userRights => '用户权利';

  @override
  String get userRightsContent =>
      '您有权：\n\n• 随时访问本隐私政策\n• 拒绝相机权限（但会影响核心功能）\n• 卸载应用以删除所有本地数据\n• 联系我们询问隐私相关问题';

  @override
  String get contactUs => '联系我们';

  @override
  String get contactUsContent =>
      '如有隐私相关问题，请通过以下方式联系我们：\n\n• 邮箱：privacy@vigiltip.app\n• 应用内反馈：设置页面\n\n我们会在收到您的询问后尽快回复。';

  @override
  String get lastUpdated => '最后更新：2026年2月';

  @override
  String get settings => '设置';

  @override
  String get about => '关于';

  @override
  String get aboutApp => '关于应用';

  @override
  String get version => '版本';

  @override
  String get developer => '开发者';

  @override
  String get appDescription => 'VigilTip是一款智能小费计算应用，通过拍照自动识别收据金额，提供三种智能小费建议。';

  @override
  String get manualInput => '手动输入金额';

  @override
  String get enterBillAmount => '手动输入账单金额';

  @override
  String get amount => '金额';

  @override
  String get calculateTip => '计算小费';

  @override
  String get cancel => '取消';

  @override
  String get enterValidAmount => '请输入有效的金额';

  @override
  String get algorithmExplanation => '算法说明';

  @override
  String get algorithmOverview => '算法概述';

  @override
  String get algorithmOverviewContent =>
      'VigilTip采用三层智能小费建议系统，根据账单金额和服务情况提供合理的小费建议。算法基于以下原则：公平性、实用性、文化适应性。';

  @override
  String get threeTierSystem => '三层建议系统';

  @override
  String get threeTierSystemContent =>
      '我们提供三个不同的小费建议层级，每个层级适用于不同的场景和偏好：\n\n• 保守型建议：适合预算有限或服务一般的情况\n• 标准建议：适合常规服务质量的餐厅\n• 慷慨型建议：适合优质服务或特殊场合';

  @override
  String get tier1Explanation => '第一层：保守建议';

  @override
  String get tier1ExplanationContent =>
      '目标：提供经济实惠的小费选择\n\n特点：\n• 通常低于10%的费率\n• 优先考虑凑整支付\n• 适合小额账单（通常低于\$40）\n• 考虑基本服务成本\n\n适用场景：\n• 快餐店、咖啡店\n• 服务质量一般\n• 预算有限的情况';

  @override
  String get tier2Explanation => '第二层：标准建议';

  @override
  String get tier2ExplanationContent =>
      '目标：提供符合常规标准的小费\n\n特点：\n• 接近10%的费率\n• 平衡考虑服务质量\n• 适合中等金额账单\n• 采用合理的凑整策略\n\n适用场景：\n• 常规餐厅用餐\n• 标准服务质量\n• 日常用餐情况';

  @override
  String get tier3Explanation => '第三层：慷慨建议';

  @override
  String get tier3ExplanationContent =>
      '目标：提供体现优质服务认可的小费\n\n特点：\n• 接近15%的费率\n• 重视服务质量\n• 适合较高金额账单\n• 体现慷慨态度\n\n适用场景：\n• 高档餐厅\n• 优质服务体验\n• 特殊场合庆祝';

  @override
  String get roundingRules => '凑整规则';

  @override
  String get roundingRulesContent =>
      '为了让小费金额更实用，我们采用智能凑整策略：\n\n• 小额账单（<\$40）：凑整到整数\n• 中等账单（\$40-\$100）：凑整到5或0结尾\n• 大额账单（>\$100）：凑整到10或0结尾\n• 优先考虑总金额的易支付性\n\n这些规则确保小费总额便于现金或电子支付。';

  @override
  String get exampleCalculations => '计算示例';

  @override
  String get exampleCalculationsContent =>
      '示例1：账单\$25.50\n• 保守建议：\$3.50（约13.8%，凑整到\$29）\n• 标准建议：\$5.50（约21.6%，凑整到\$31）\n• 慷慨建议：\$7.50（约29.4%，凑整到\$33）\n\n示例2：账单\$68.25\n• 保守建议：\$8.75（约12.8%，凑整到\$77）\n• 标准建议：\$11.75（约17.2%，凑整到\$80）\n• 慷慨建议：\$16.75（约24.6%，凑整到\$85）\n\n示例3：账单\$125.00\n• 保守建议：\$15.00（12%，凑整到\$140）\n• 标准建议：\$25.00（20%，凑整到\$150）\n• 慷慨建议：\$35.00（28%，凑整到\$160）';

  @override
  String get transparencyCommitment => '透明度承诺';

  @override
  String get transparencyCommitmentContent =>
      '我们承诺算法的完全透明：\n\n• 所有计算逻辑公开说明\n• 不隐藏任何复杂规则\n• 欢迎用户反馈和建议\n• 持续优化算法公平性\n\n我们相信透明度能够建立用户信任，让每个小费决策都更加明智。';

  @override
  String get whyTransparent => '为什么选择透明？';

  @override
  String get whyTransparentContent =>
      '在数字时代，算法透明度是用户信任的基础。我们公开小费计算逻辑，因为：\n\n• 您有权知道建议的来源\n• 透明度促进算法公平性\n• 帮助您做出明智决策\n• 建立长期用户信任\n\nVigilTip致力于成为您最值得信赖的小费计算伙伴。';

  @override
  String get recognizingReceiptContent => '正在识别账单内容，请稍候...';

  @override
  String get viewRawText => '查看识别的原始文本';

  @override
  String get rawTextDescription => '显示OCR识别的原始文字内容';

  @override
  String get backToCamera => '返回拍照';

  @override
  String get linesOfText => '行文本';

  @override
  String get manualInputAmount => '手动输入金额: \$';

  @override
  String get retakePhoto => '重新拍照';

  @override
  String get ocrRecognitionResult => 'OCR 识别结果：';

  @override
  String get emptyLine => '[空行]';

  @override
  String get billContainsServiceCharge => '账单已包含服务费';

  @override
  String get serviceChargeAmount => '服务费金额';

  @override
  String get preTaxPercentage => '% 税前';

  @override
  String get totalPayment => '总计支付';

  @override
  String get highTipAmount => '小费金额较高';

  @override
  String get highTipWarning => '最低档小费已超过 \$20，请检查账单金额是否正确，或考虑手动输入准确的金额。';

  @override
  String get privacyPolicyTitle => '隐私政策';

  @override
  String get privacyPolicyDialogMessage =>
      '欢迎使用 VigilTip！在使用我们的应用之前，请阅读我们的隐私政策，了解我们如何保护您的数据。';

  @override
  String get readPrivacyPolicy => '阅读隐私政策';

  @override
  String get accept => '接受并继续';

  @override
  String get decline => '拒绝';

  @override
  String get privacyPolicyRequired => '您必须接受隐私政策才能使用 VigilTip。';

  @override
  String get privacyPolicyUrl =>
      'https://pigjr.github.io/VigilTip/privacy_policy.html';
}
