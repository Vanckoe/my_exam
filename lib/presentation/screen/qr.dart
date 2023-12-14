import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_market/presentation/bloc/bloc/bloc/qr_bloc.dart';
import 'package:flutter_market/presentation/bloc/bloc/bloc/qr_event.dart';
import 'package:flutter_market/presentation/bloc/bloc/bloc/qr_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QRScanBloc(),
      child: QRScanView(),
    );
  }
}

class QRScanView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanViewState();
}

class _QRScanViewState extends State<QRScanView> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          buildQrView(context),
          Positioned(bottom: 10, child: buildResult()),
        ],
      ),
    );
  }

  Widget buildQrView(BuildContext context) {
    final bloc = BlocProvider.of<QRScanBloc>(context);
    return QRView(
      key: qrKey,
      onQRViewCreated: (QRViewController controller) {
        bloc.setController(controller);
        bloc.add(QRScanStarted());
      },
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  Widget buildResult() {
    return BlocBuilder<QRScanBloc, QRScanState>(
      builder: (context, state) {
        if (state is QRScanSuccess) {
          return _buildResultContainer('Result: ${state.code}', Colors.green);
        } else if (state is QRScanFailure) {
          return _buildResultContainer('Failed to scan QR Code', Colors.red);
        }
        return _buildResultContainer('Scan a QR Code', Colors.white);
      },
    );
  }

  Widget _buildResultContainer(String text, Color textColor) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
    );
  }

  @override
  void dispose() {
    BlocProvider.of<QRScanBloc>(context, listen: false).qrViewController?.dispose();
    super.dispose();
  }
}
