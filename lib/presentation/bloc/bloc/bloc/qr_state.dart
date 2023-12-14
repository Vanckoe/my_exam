abstract class QRScanState {}

class QRScanInitial extends QRScanState {}

class QRScanSuccess extends QRScanState {
  final String code;

  QRScanSuccess(this.code);
}

class QRScanFailure extends QRScanState {}