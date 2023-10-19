import 'dart:io';

import 'package:foodie_connect/core_utils/export_dependency.dart';
import 'package:foodie_connect/routes/routes_export.dart';
import 'package:foodie_connect/widgets/round_button.dart';
import 'package:foodie_connect/widgets/text_form_field_with_prefix_icon_label.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../core_utils/flush_bar_message.dart';
import '../provider/qr_provider.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  TextEditingController usernameController = TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  late QrProvider providerQr;

  bool isBack=true;
  @override
  void initState() {
    super.initState();
    providerQr = Provider.of<QrProvider>(context, listen: false);

  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Consumer<QrProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                LocalStrings.qRCode,
                style: AppStyle.loginTitleTextStyle,
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: null,
              // iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.only(
                  left: AppDimens.width15,
                  right: AppDimens.width15,
                  top: AppDimens.height20,
                  bottom: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppDimens.radius20),
                          color: AppColors.color3F3F3F),
                      height: AppDimens.height300,
                      width: AppDimens.width300,
                      child: QRView(
                        overlay: QrScannerOverlayShape(
                          borderRadius: AppDimens.radius10,
                        ),
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                      ),
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    Text(
                      LocalStrings.lineUpYourQrCode,
                      textAlign: TextAlign.center,
                      style: AppStyle.onBoardingDescriptionTextStyle,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Divider(
                                color: AppColors.color000000, thickness: 1)),
                        Text(
                          LocalStrings.or,
                          textAlign: TextAlign.center,
                          style: AppStyle.onBoardingDescriptionTextStyle,
                        ),
                        Flexible(
                            child: Divider(
                                color: AppColors.color000000, thickness: 1)),
                      ],
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    FormFieldWithPrefixIcon(
                      focusNode: FocusNode(),
                      hintText: LocalStrings.influencerUsername,
                      controller: usernameController,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    RoundButton(
                        color: Colors.transparent,
                        textColor: AppColors.color000000,
                        text: LocalStrings.goButtonText,
                        onPressedFunction: () {
                          if (usernameController.text.isNotEmpty) {
                            providerQr.qrUpdateApi(
                                qrCode: "",
                                username: usernameController.text,
                                context: context);
                          } else {
                            FlushBarMessage.flushBarBottomErrorMessage(
                                message: LocalStrings.pleaseEnterUserName,
                                context: context);
                          }
                        }),
                  ],
                ),
              ),
            )),
          );
        },
      ),
    );
  }

  // void _onQRViewCreated(
  //   QRViewController controller,
  // ) {
  //   this.controller = controller;
  //
  //   controller.scannedDataStream.listen((scanData) {
  //     if (scanData.code!.isNotEmpty) {
  //
  //     }
  //
  //     // usernameController.text = scanData.code.toString();
  //     if (kDebugMode) {
  //       print(scanData.code);
  //     }
  //   });
  // }
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      controller.resumeCamera();
    });
    controller.scannedDataStream.listen((scanData) {
      result = scanData;

        providerQr.qrUpdateApi(
            qrCode: scanData.code.toString(),
            username: usernameController.text,
            context: context);
        if(context.mounted!){
          setState(() {
            this.controller = controller;
            controller.pauseCamera();
          });
        }else if(context.mounted){
          setState(() {
            this.controller = controller;
            controller.resumeCamera();
          });
        }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
