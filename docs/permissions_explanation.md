# VigilTip - Permissions Usage Explanation

## Permission Request Explanation

### 1. Camera Permission
**Purpose**: Capture receipt photos for OCR recognition
**Necessity**: Core functionality required
**Usage Scenarios**: 
- Requested when user clicks camera button
- Capture receipt photos for amount recognition
- Photos processed locally only, no cloud upload

**User Benefits**: 
- Automatic receipt amount recognition
- Avoid manual input errors
- Provide accurate tip calculations

### 2. Record Audio Permission
**Status**: Explicitly removed
**Explanation**: App does not use any audio functionality
**Technical Implementation**: Explicitly removed via tools:node="remove" in AndroidManifest.xml

### 3. Read Memory Card Permission
**Status**: Explicitly removed
**Explanation**: App does not need to read memory card contents
**Technical Implementation**: Explicitly removed via tools:node="remove" in AndroidManifest.xml
**Alternative Solution**: Use app internal storage and temporary cache

## Privacy Protection Commitment

### Local Processing
- All receipt photos processed on device locally
- No upload to any cloud servers
- No user personal data collection

### Data Security
- Temporary files automatically cleaned
- Use device encrypted storage
- No user behavior data collection

### Transparency
- Complete transparency in permission usage
- Users can revoke permissions at any time
- Provide complete privacy policy

## Technical Implementation Details

### Camera Permission Implementation
```dart
// Request only when user actively operates
final cameraController = await cameraController.initialize();
// Local photo processing
final image = await cameraController.takePicture();
// OCR recognition performed locally
final text = await googleMlKit.processImage(image);
```

### Permission Removal Configuration
```xml
<!-- Explicitly remove unnecessary permissions -->
<uses-permission android:name="android.permission.RECORD_AUDIO" tools:node="remove" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" tools:node="remove" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" tools:node="remove" />
```

## User Control

### Permission Management
- Users can manage permissions in system settings
- App provides permission usage explanation
- Support functionality degradation after permission revocation

### Data Control
- Users can delete app to clear all data
- No data export function provided (because no data collection)
- Complete user data control

## Compliance

### GDPR Compliance
- No personal data collection
- Provide transparent privacy policy
- User data completely self-controlled

### App Store Policy Compliance
- Only request necessary permissions
- Provide permission usage explanation
- Comply with minimum permission principle

## Contact Information

For permission-related questions, please contact through:
- In-app feedback
- GitHub Issues: https://github.com/pigjr/VigilTip/issues
- Privacy Policy: https://pigjr.github.io/VigilTip/

## Security Measures

### Data Protection
- All processing performed locally on device
- No network transmission of sensitive data
- Automatic cleanup of temporary files
- Device-level encryption for local storage

### Access Control
- Permissions requested only when needed
- Clear explanation for each permission
- User can deny permissions without app crash
- Graceful degradation when permissions denied

## Technical Architecture

### Permission Flow
1. User initiates camera action
2. App requests camera permission
3. Photo captured and processed locally
4. OCR recognition performed on device
5. Results displayed to user
6. Temporary files automatically deleted

### Security Architecture
- No external API calls for OCR processing
- All ML processing performed locally
- No data persistence beyond session
- No analytics or tracking implemented
