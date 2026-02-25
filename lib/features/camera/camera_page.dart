import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../gen_l10n/app_localizations.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  String? _error;
  bool _isCapturing = false;
  bool _showManualInput = false;
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 锁定竖向方向
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final status = await Permission.camera.request();
      if (!mounted) return;
      if (!status.isGranted) {
        setState(() {
          _error = AppLocalizations.of(context)!.cameraPermissionDenied;
        });
        return;
      }
    } on MissingPluginException {
      // permission_handler not implemented on this platform (e.g. Linux, Windows, web); proceed without it.
    }
    try {
      _cameras = await availableCameras();
      if (!mounted) return;
      if (_cameras == null || _cameras!.isEmpty) {
        setState(() {
          _error = AppLocalizations.of(context)!.noCameraFound;
        });
        return;
      }
      final back = _cameras!.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras!.first,
      );
      _controller = CameraController(
        back,
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.jpeg,
        enableAudio: false,
      );
      await _controller!.initialize();
      if (mounted) setState(() {});
    } on MissingPluginException {
      if (mounted) {
        setState(() {
          _error = AppLocalizations.of(context)!.cameraNotSupportedOnPlatform;
        });
      }
    } on CameraException catch (e) {
      if (mounted) {
        setState(() {
          _error = AppLocalizations.of(context)!.cameraInitFailed(e.description ?? '');
        });
      }
    }
  }

  @override
  void dispose() {
    // 恢复所有方向
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _capture() async {
    if (_controller == null || !_controller!.value.isInitialized || _isCapturing) return;
    setState(() => _isCapturing = true);
    try {
      final file = await _controller!.takePicture();
      if (!mounted) return;
      context.go('/result', extra: file.path);
    } on CameraException catch (e) {
      if (mounted) {
        setState(() {
          _error = AppLocalizations.of(context)!.captureFailed(e.description ?? '');
        });
      }
    } catch (e) {
      debugPrint('Capture error: $e');
      // Filter out known device-specific errors that don't affect functionality
      if (e.toString().contains('com.oplus.statistics.provider') ||
          e.toString().contains('OplusStatistics')) {
        debugPrint('Ignoring OnePlus/Oppo statistics provider error (device-specific, non-critical)');
      } else {
        if (mounted) {
          setState(() {
            _error = AppLocalizations.of(context)!.captureFailed('Unexpected error occurred');
          });
        }
      }
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final xFile = await picker.pickImage(source: ImageSource.gallery);
      if (!mounted) return;
      if (xFile == null) return;
      final path = xFile.path;
      if (path.isNotEmpty) {
        context.go('/result', extra: path);
      }
    } on MissingPluginException {
      if (mounted) {
        setState(() {
          _error = AppLocalizations.of(context)!.cameraNotSupportedOnPlatform;
        });
      }
    }
  }

  void _submitManualAmount() {
    final l10n = AppLocalizations.of(context)!;
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) return;
    
    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.enterValidAmount)),
      );
      return;
    }
    
    // Create a manual receipt data and navigate to result
    context.go('/result', extra: {'manual': true, 'amount': amount});
  }

  void _toggleManualInput() {
    setState(() {
      _showManualInput = !_showManualInput;
      if (!_showManualInput) {
        _amountController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.scanReceipt)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_error!, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.photo_library),
                  label: Text(l10n.pickImageFromGallery),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => _initCamera(),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_controller == null || !_controller!.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/images/VigilTip1.png',
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 12),
              Text(l10n.scanReceipt),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.photo_library),
              onPressed: _pickImage,
              tooltip: l10n.pickImageFromGallery,
            ),
          ],
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        // 在首页按返回键时退出应用
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/images/VigilTip1.png',
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 12),
              Text(l10n.scanReceipt),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.photo_library),
              onPressed: _pickImage,
              tooltip: l10n.pickImageFromGallery,
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => context.go('/settings'),
              tooltip: l10n.settings,
            ),
          ],
        ),
        body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: ClipRect(
              child: AspectRatio(
                aspectRatio: 9 / 16, // 强制竖向比例
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller!.value.previewSize!.height,
                    height: _controller!.value.previewSize!.width,
                    child: CameraPreview(_controller!),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                if (_showManualInput) _buildManualInputSection(),
                _buildCaptureButton(l10n),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildCaptureButton(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton.icon(
            onPressed: _isCapturing ? null : _capture,
            icon: _isCapturing
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.camera_alt),
            label: Text(_isCapturing ? l10n.processing : l10n.capture),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
          const SizedBox(height: 12),
          if (!_showManualInput)
            FilledButton.icon(
              onPressed: _toggleManualInput,
              icon: const Icon(Icons.edit),
              label: Text(l10n.manualInput),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildManualInputSection() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.enterBillAmount,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.amount,
              prefixText: '\$',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            autofocus: true,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: _submitManualAmount,
                  icon: const Icon(Icons.calculate),
                  label: Text(l10n.calculateTip),
                ),
              ),
              const SizedBox(width: 12),
              TextButton.icon(
                onPressed: _toggleManualInput,
                icon: const Icon(Icons.close),
                label: Text(l10n.cancel),
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
