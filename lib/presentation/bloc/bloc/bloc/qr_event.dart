abstract class QRScanEvent {}

class QRScanStarted extends QRScanEvent {}

class QRCodeScanned extends QRScanEvent {
  final String? code;

  QRCodeScanned(this.code);
}