import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_market/presentation/bloc/bloc/bloc/qr_event.dart';
import 'package:flutter_market/presentation/bloc/bloc/bloc/qr_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class QRScanBloc extends Bloc<QRScanEvent, QRScanState> {
  QRViewController? qrViewController;

  QRScanBloc() : super(QRScanInitial()) {
    on<QRScanStarted>((event, emit) {
    });

    on<QRCodeScanned>((event, emit) {
      if (event.code != null) {
        emit(QRScanSuccess(event.code!));
      } else {
        emit(QRScanFailure());
      }
    });
  }

  void setController(QRViewController controller) {
    this.qrViewController = controller;
    qrViewController!.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        add(QRCodeScanned(scanData.code!));
      }
    });
  }
}