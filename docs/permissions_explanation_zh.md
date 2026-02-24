# VigilTip - 权限使用说明

## 权限请求说明

### 1. Camera (相机权限)
**用途**: 拍摄收据照片进行OCR识别
**必要性**: 核心功能必需
**使用场景**: 
- 用户点击相机按钮时请求权限
- 拍摄收据照片进行金额识别
- 照片仅在本地处理，不上传云端

**用户价值**: 
- 自动识别收据金额
- 避免手动输入错误
- 提供准确的小费计算

### 2. Record Audio (录音权限)
**状态**: 已明确移除
**说明**: 应用不使用任何音频功能
**技术实现**: 通过AndroidManifest.xml中的tools:node="remove"明确移除

### 3. Read the contents of your memory card (存储权限)
**状态**: 已明确移除
**说明**: 应用不需要读取存储卡内容
**技术实现**: 通过AndroidManifest.xml中的tools:node="remove"明确移除
**替代方案**: 使用应用内部存储和临时缓存

## 隐私保护承诺

### 本地处理
- 所有收据照片在设备本地处理
- 不上传到任何云端服务器
- 不存储用户个人数据

### 数据安全
- 临时文件自动清理
- 使用设备加密存储
- 不收集用户行为数据

### 透明度
- 权限使用完全透明
- 用户可随时撤销权限
- 提供完整的隐私政策

## 技术实现细节

### 相机权限实现
```dart
// 仅在用户主动操作时请求
final cameraController = await cameraController.initialize();
// 本地处理照片
final image = await cameraController.takePicture();
// OCR识别在本地进行
final text = await googleMlKit.processImage(image);
```

### 权限移除配置
```xml
<!-- 明确移除不需要的权限 -->
<uses-permission android:name="android.permission.RECORD_AUDIO" tools:node="remove" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" tools:node="remove" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" tools:node="remove" />
```

## 用户控制

### 权限管理
- 用户可在系统设置中管理权限
- 应用提供权限使用说明
- 支持权限撤销后的功能降级

### 数据控制
- 用户可删除应用清除所有数据
- 不提供数据导出功能（因为无数据收集）
- 完全的用户数据控制权

## 合规性

### GDPR合规
- 不收集个人数据
- 提供透明的隐私政策
- 用户数据完全自控

### 应用商店政策
- 仅请求必需权限
- 提供权限使用说明
- 符合最小权限原则

## 联系方式

如有权限相关问题，请通过以下方式联系：
- 应用商店内反馈
- GitHub Issues: https://github.com/pigjr/VigilTip/issues
- 隐私政策: https://pigjr.github.io/VigilTip/
