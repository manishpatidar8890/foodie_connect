import 'dart:io';

import 'package:foodie_connect/core_utils/app_colors.dart';
import 'package:foodie_connect/core_utils/app_image.dart';
import 'package:foodie_connect/widgets/round_button.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core_utils/app_dimens.dart';
import '../../../../../core_utils/app_style.dart';
import '../../../../../core_utils/flush_bar_message.dart';
import '../../../../../core_utils/local_strings.dart';
import '../../../../../routes/routes_export.dart';
import '../../../../../widgets/text_form_field_with_prefix_icon_label.dart';
import '../../sign_up_influencer/sign_up_provider/sign_up_provider.dart';

class CompleteBusinessProfileScreen extends StatefulWidget {
  const CompleteBusinessProfileScreen({
    super.key,
  });

  @override
  State<CompleteBusinessProfileScreen> createState() =>
      _CompleteBusinessProfileScreenState();
}

class _CompleteBusinessProfileScreenState
    extends State<CompleteBusinessProfileScreen> {
  TextEditingController emailWebsiteController = TextEditingController();
  TextEditingController preferredNumberController = TextEditingController();
  TextEditingController businessNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocalStrings.completeProfile,
          style: AppStyle.loginTitleTextStyle,
        ),centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        bottom: false,
        child: Consumer<SignUpProvider>(builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimens.width15, vertical: AppDimens.height15),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () async {
                            XFile? image = await pickImage(context: context);
                            provider.setBusinessImage(image!);
                          },
                          splashFactory: NoSplash.splashFactory,
                          child: showImage(provider.businessImage)),
                    ],
                  ),
                  SizedBox(
                    height: AppDimens.height30,
                  ),
                  FormFieldWithPrefixIcon(
                    controller: emailWebsiteController,
                    hintText: LocalStrings.emailWebsite,
                    focusNode: FocusNode(),
                  ),
                  SizedBox(
                    height: AppDimens.height20,
                  ),
                  FormFieldWithPrefixIcon(
                    controller: preferredNumberController,
                    hintText: LocalStrings.enterPreferredNumber,isNumber: true,
                    keyboardType: TextInputType.number,maxLength: 10,
                    focusNode: FocusNode(),
                  ),
                  SizedBox(
                    height: AppDimens.height20,
                  ),
                  FormFieldWithPrefixIcon(
                    controller: businessNumberController,
                    hintText: LocalStrings.enterBusinessNumber,isNumber: true,
                    keyboardType: TextInputType.number,maxLength: 10,
                    focusNode: FocusNode(),
                  ),
                  SizedBox(
                    height: AppDimens.height20,
                  ),
                  FormFieldWithPrefixIcon(
                    controller: addressController,
                    hintText: LocalStrings.enterAddress,
                    maxLines: 3,
                    focusNode: FocusNode(),
                  ),
                  SizedBox(
                    height: AppDimens.height20,
                  ),
                  Container(
                    height: AppDimens.height180,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppImage.map), fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    height: AppDimens.height40,
                  ),
                  RoundButton(
                      color: Colors.transparent,
                      textColor: AppColors.color000000,
                      text: LocalStrings.doneButtonText,
                      onPressedFunction: () {
                        if (emailWebsiteController.text.isEmpty &&
                            preferredNumberController.text.isEmpty &&
                            businessNumberController.text.isEmpty &&
                            addressController.text.isEmpty) {
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: LocalStrings.pleaseEnterCredential,
                              context: context);
                        } else if (emailWebsiteController.text.isEmpty) {
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: LocalStrings.pleaseEnterWebsiteEmail,
                              context: context);
                        } else if (provider.businessImage == null) {
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: LocalStrings.pleaseUploadProfile,
                              context: context);
                        } else if (preferredNumberController.text.isEmpty) {
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: LocalStrings.pleaseEnterPreferredNumber,
                              context: context);
                        } else if (businessNumberController.text.isEmpty) {
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: LocalStrings.pleaseEnterBusinessNumber,
                              context: context);
                        } else if (addressController.text.isEmpty) {
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: LocalStrings.pleaseEnterBusinessAddress,
                              context: context);
                        }else {
                          provider.completeBusinessProfile(
                              address: addressController.text,
                              website: emailWebsiteController.text,
                              businessNumber: businessNumberController.text,
                              preferredNumber: preferredNumberController.text,
                              image: provider.businessImage,
                              context: context);
                        }
                      }),
                  SizedBox(
                    height: AppDimens.height20,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  showImage(XFile? file) {
    if (file != null) {
      return Container(
          height: AppDimens.height100,
          width: AppDimens.width100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.radius50),
            image: DecorationImage(
                fit: BoxFit.fill, image: FileImage(File(file.path))),
          ));
    }

    return Container(
        height: AppDimens.height100,
        width: AppDimens.width100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radius50),
          image: const DecorationImage(
              fit: BoxFit.fill, image: AssetImage(AppImage.dummy)),
        ));
  }

  Future<XFile?> pickImage({@required BuildContext? context}) async {
    int? type;
    return showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(AppDimens.width15),
          child: Container(
            padding: EdgeInsets.only(
                left: AppDimens.width10,
                right: AppDimens.width10,
                bottom: AppDimens.width10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      LocalStrings.selectImageSource,
                      style: AppStyle.hintTextStyle,
                    )),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.clear,
                          size: AppDimens.width20,
                          color: Colors.red,
                        ))
                  ],
                ),
                SizedBox(
                  height: AppDimens.height20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.green.withOpacity(0.2),
                      padding:
                          EdgeInsets.symmetric(horizontal: AppDimens.width15),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.camera,
                            color: Colors.green,
                          ),
                          TextButton(
                            child: Text(
                              LocalStrings.camera,
                              style: AppStyle.hintTextStyle,
                            ),
                            onPressed: () async {
                              type = 1;
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.red.withOpacity(0.2),
                      padding:
                          EdgeInsets.symmetric(horizontal: AppDimens.width15),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.landscape_rounded,
                            color: Colors.red,
                          ),
                          TextButton(
                            child: Text(
                              LocalStrings.gallery,
                              style: AppStyle.hintTextStyle,
                            ),
                            onPressed: () async {
                              type = 2;
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppDimens.height20,
                ),
              ],
            ),
          ),
        );
      },
    ).then((v) async {
      if (type != null) {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(
            source: type == 1 ? ImageSource.camera : ImageSource.gallery);
        if (image != null) {
          return XFile(image.path);
        }
        return null;
      }
      return null;
    });
  }
}
