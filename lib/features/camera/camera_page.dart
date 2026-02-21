import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final status = await Permission.camera.request();
    if (!mounted) return;
    if (!status.isGranted) {
      setState(() {
        _error = AppLocalizations.of(context)!.cameraPermissionDenied;
      });
      return;
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
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
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
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => _initCamera(),
                  child: Text(l10n.retry),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text(l10n.back),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_controller == null || !_controller!.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.scanReceipt)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.scanReceipt)),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: CameraPreview(_controller!),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: FilledButton.icon(
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
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
