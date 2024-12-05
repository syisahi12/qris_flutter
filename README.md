# Flutter QRIS Generator

A Flutter application for generating dynamic QRIS codes, based on the work by [Rachma Azis](https://github.com/razisek).

## Features

- Generate dynamic QRIS codes from static QRIS strings
- Input custom nominal amounts
- Real-time QR code preview
- Material Design 3 UI
- Form validation
- CRC16 checksum validation

## Installation

1. Ensure you have Flutter installed on your system
2. Clone this repository:
```bash
git clone https://github.com/syisahi12/qris_flutter.git
```
3. Navigate to the project directory:
```bash
cd qris_flutter
```
4. Install dependencies:
```bash
flutter pub get
```
5. Run the application:
```bash
flutter run
```

## Usage

1. Launch the application
2. Enter your static QRIS ID in the first input field
3. Enter the nominal amount in the second input field
4. Click "Generate QR Code"
5. The dynamic QR code will be displayed below the form

## Code Example

```dart
// Generate dynamic QRIS string
final qrisString = makeString(
  staticQrisId,
  {'nominal': nominalAmount},
);

// Display QR code
QrImageView(
  data: qrisString,
  version: QrVersions.auto,
  size: 200.0,
);
```

## Parameters

| Parameter | Required | Description |
|-----------|----------|-------------|
| qrisId    | Yes      | The static QRIS ID to be converted |
| nominal   | Yes      | The nominal amount for the dynamic QRIS |
| taxtype   | No       | Tax type ('p' for percentage, 'r' for rupiah) |
| fee       | No       | Tax fee amount |

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  qr_flutter: ^4.1.0
  cupertino_icons: ^1.0.2
```

## Project Structure

```
lib/
├── main.dart
├── screens/
│   └── qr_generator_screen.dart
└── utils/
    └── qris_generator.dart
```

## Credits

This project is a Flutter implementation based on the [qris-dinamis](https://github.com/razisek/Qris-Dinamis) Node.js package by Rachma Azis.

## License

MIT License

## Author

Original QRIS Dynamic Generator by [Rachma Azis](https://github.com/razisek)
