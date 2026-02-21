import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// Offline OCR using ML Kit. Returns lines of text from a receipt image file.
class OcrService {
  OcrService() : _recognizer = TextRecognizer(script: TextRecognitionScript.latin);

  final TextRecognizer _recognizer;

  /// Run OCR on image at [filePath]. Returns list of text lines, or empty on failure.
  Future<List<String>> recognizeFromFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) return [];
    try {
      final inputImage = InputImage.fromFilePath(filePath);
      final recognized = await _recognizer.processImage(inputImage);
      final lines = <String>[];
      for (final block in recognized.blocks) {
        for (final line in block.lines) {
          final text = line.text.trim();
          if (text.isNotEmpty) lines.add(text);
        }
      }
      return lines;
    } catch (_) {
      return [];
    }
  }

  void dispose() {
    _recognizer.close();
  }
}
