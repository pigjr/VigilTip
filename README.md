# VigilTip

Flutter Android app: scan a receipt with the camera, get offline OCR, then tip suggestions based on pre-tax amount with rounded amounts and reasons for each option.

## Features

- **Offline OCR**: Google ML Kit text recognition (no cloud, no privacy risk).
- **Receipt parsing**: Detects subtotal (pre-tax), tax, total, and whether tip/service charge is already included.
- **Tip engine**: Multiple tiers (e.g. 15%, 18%, 20%) with amounts rounded down to whole numbers; each option has a short reason for the user/merchant.
- **No-tip when included**: If the bill already includes gratuity or service charge, the app suggests not adding more and explains why.

## Requirements

- Flutter 3.x, Android minSdk 21+.
- Camera permission.

## Run

```bash
flutter pub get
flutter run
```

Build APK:

```bash
flutter build apk
```

## Project structure

- `lib/features/home/` – Home with "Scan receipt" entry.
- `lib/features/camera/` – Camera preview and capture.
- `lib/features/result/` – Parsed receipt summary and tip options (or no-tip message).
- `lib/core/ocr/` – ML Kit OCR service.
- `lib/core/receipt/` – Receipt parser and model.
- `lib/core/tip/` – Tip engine and models.
