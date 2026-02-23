import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;

/// Offline OCR using ML Kit. Returns lines of text from a receipt image file.
class OcrService {
  OcrService() : _recognizer = TextRecognizer(script: TextRecognitionScript.latin);

  final TextRecognizer _recognizer;

  /// Run OCR on image at [filePath]. Returns list of text lines, or empty on failure.
  Future<List<String>> recognizeFromFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) return [];
    
    debugPrint('=== OCR Processing Started ===');
    debugPrint('File path: $filePath');
    debugPrint('File exists: ${await file.exists()}');
    debugPrint('File size: ${await file.length()} bytes');
    
    try {
      // Convert WebP to JPEG if needed
      final processedFilePath = await _convertWebPToJpegIfNeeded(filePath);
      
      // Log conversion for debugging (remove in production)
      if (processedFilePath != filePath) {
        debugPrint('WebP image converted to JPEG: $filePath -> $processedFilePath');
      }
      
      debugPrint('Creating InputImage from: $processedFilePath');
      final inputImage = InputImage.fromFilePath(processedFilePath);
      debugPrint('InputImage created: ${inputImage.metadata}');
      
      debugPrint('Starting ML Kit text recognition...');
      final recognized = await _recognizer.processImage(inputImage);
      debugPrint('ML Kit recognition completed');
      
      final lines = <String>[];
      int blockCount = 0;
      for (final block in recognized.blocks) {
        blockCount++;
        debugPrint('Block $blockCount: ${block.boundingBox}');
        for (final line in block.lines) {
          final text = line.text.trim();
          if (text.isNotEmpty) {
            lines.add(text);
            debugPrint('  Line: "$text" (confidence: ${line.confidence?.toStringAsFixed(2) ?? "N/A"})');
          }
        }
      }
      
      debugPrint('=== OCR Raw Text Analysis ===');
      debugPrint('Total lines found: ${lines.length}');
      for (int i = 0; i < lines.length; i++) {
        debugPrint('Raw line $i: "${lines[i]}"');
        // Check for service charge patterns
        if (lines[i].toLowerCase().contains('service') || 
            lines[i].toLowerCase().contains('charge') ||
            lines[i].toLowerCase().contains('服务费')) {
          debugPrint('  📍 Potential service charge line: "${lines[i]}"');
        }
        // Check for amount patterns
        if (lines[i].contains(RegExp(r'[\$¥€]\s*[\d]'))) {
          debugPrint('  💰 Contains currency: "${lines[i]}"');
        }
      }
      debugPrint('=== End OCR Analysis ===');
      
      debugPrint('OCR Results Summary:');
      debugPrint('- Total blocks: $blockCount');
      debugPrint('- Total lines extracted: ${lines.length}');
      debugPrint('- All lines: ${lines.join('\n')}');
      
      // Clean up temporary file if conversion happened
      if (processedFilePath != filePath) {
        try {
          await File(processedFilePath).delete();
          debugPrint('Temporary file cleaned up: $processedFilePath');
        } catch (_) {
          // Ignore cleanup errors
        }
      }
      
      debugPrint('=== OCR Processing Completed ===');
      
      return lines;
    } on MissingPluginException catch (e) {
      debugPrint('OCR plugin not available: ${e.message}');
      debugPrint('This might be a build environment issue. The app should work on a real device.');
      // Return empty list for now - in production, this should work on real devices
      return [];
    } catch (e) {
      debugPrint('OCR processing error: $e');
      // Filter out known device-specific errors that don't affect functionality
      if (e.toString().contains('com.oplus.statistics.provider') ||
          e.toString().contains('OplusStatistics')) {
        debugPrint('Ignoring OnePlus/Oppo statistics provider error (device-specific, non-critical)');
      } else {
        debugPrint('Unexpected OCR error: $e');
      }
      return [];
    }
  }

  /// Convert WebP images to JPEG for ML Kit compatibility.
  /// Returns the original file path if no conversion is needed, or a temporary JPEG file path.
  Future<String> _convertWebPToJpegIfNeeded(String filePath) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    
    // Check if the file is WebP format
    if (!_isWebPFormat(bytes)) {
      return filePath; // Not WebP, return original path
    }
    
    try {
      // Decode WebP and encode as JPEG
      final image = img.decodeImage(bytes);
      if (image == null) {
        return filePath; // Failed to decode, return original
      }
      
      // Create temporary JPEG file
      final tempDir = file.parent;
      final tempFile = File('${tempDir.path}/temp_${DateTime.now().millisecondsSinceEpoch}.jpg');
      final jpegBytes = img.encodeJpg(image, quality: 95);
      await tempFile.writeAsBytes(jpegBytes);
      
      return tempFile.path;
    } catch (_) {
      return filePath; // Conversion failed, return original
    }
  }

  /// Check if the image bytes represent a WebP format.
  bool _isWebPFormat(Uint8List bytes) {
    if (bytes.length < 12) return false;
    
    // WebP file signature check
    // RIFF....WEBP
    return bytes[0] == 0x52 && // R
           bytes[1] == 0x49 && // I
           bytes[2] == 0x46 && // F
           bytes[3] == 0x46 && // F
           bytes[8] == 0x57 && // W
           bytes[9] == 0x45 && // E
           bytes[10] == 0x42 && // B
           bytes[11] == 0x50;  // P
  }

  void dispose() {
    _recognizer.close();
  }
}
