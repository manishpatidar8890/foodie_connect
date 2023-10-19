
import 'dart:io';

import 'package:foodie_connect/core_utils/app_colors.dart';
import 'package:foodie_connect/core_utils/app_image.dart';
import 'package:foodie_connect/widgets/round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../../core_utils/app_dimens.dart';
import '../../../../../core_utils/app_style.dart';
import '../../../../../core_utils/flush_bar_message.dart';
import '../../../../../core_utils/local_strings.dart';
import '../../../../../routes/routes_export.dart';
import '../../../../../widgets/text_form_field_with_prefix_icon_label.dart';
import '../sign_up_provider/sign_up_provider.dart';

class CompleteInfluencerProfileScreen extends StatefulWidget {
  const CompleteInfluencerProfileScreen({
    super.key,
  });

  @override
  State<CompleteInfluencerProfileScreen> createState() =>
      _CompleteInfluencerProfileScreenState();
}

class _CompleteInfluencerProfileScreenState
    extends State<CompleteInfluencerProfileScreen> {
  TextEditingController numberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController tikTokController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String? _dropDownValue;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.black26, // <-- SEE HERE
            onPrimary: AppColors.color000000, // <-- SEE HERE
            onSurface:AppColors.color000000, // <-- SEE HERE
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.grey, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd'). format(picked);
        print(formattedDate);
        dobController.text = formattedDate;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            LocalStrings.completeProfile,
            style: AppStyle.loginTitleTextStyle,
          ),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () async {
                                XFile? image =
                                    await pickImage(context: context);
                                provider.setInfluencerImage(image!);
                              },
                              splashFactory: NoSplash.splashFactory,
                              child: showImage(provider.influencerImage)),
                        ],
                      ),
                      SizedBox(
                        height: AppDimens.height30,
                      ),
                      Text(
                        LocalStrings.influencerProfile,
                        style: AppStyle.influencerProfileTextStyle,
                      ),
                      SizedBox(
                        height: AppDimens.height5,
                      ),
                      FormFieldWithPrefixIcon(
                        controller: numberController,keyboardType: TextInputType.number,maxLength: 10,
                        hintText: LocalStrings.enterPhoneNumber,
                        focusNode: FocusNode(),isNumber: true,
                      ),
                      SizedBox(
                        height: AppDimens.height20,
                      ),
                      DropdownButtonFormField(
                        value:  provider.gender,
                        decoration: InputDecoration(
                          prefixIconConstraints: BoxConstraints(
                            maxHeight: AppDimens.height35,
                            minHeight: AppDimens.height35,
                            minWidth: AppDimens.width35,
                          ),
                          filled: true,
                          fillColor: AppColors.colorEEEEEE,
                          hintText: LocalStrings.gender,
                          hintStyle: AppStyle.hintTextStyle,
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: AppColors.color262626,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(AppDimens.height15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: AppColors.color262626,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: AppColors.redColor,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: AppColors.redColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: AppColors.color262626,
                            ),
                          ),
                          focusColor: AppColors.primaryColor,
                        ),
                        items: ['Male', 'Female', 'Other'].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          provider.setGender(val!);
print(provider.gender);
                        },
                      ),
                      SizedBox(
                        height: AppDimens.height20,
                      ),
                      FormFieldWithPrefixIcon(
                        onTap: () {
                          _selectDate(context);
                        },
                        readOnly: true,
                        image: AppImage.calenderIcon,
                        controller: dobController,
                        prefixIcon: true,
                        hintText: LocalStrings.dateOfBirth,
                        focusNode: FocusNode(),
                      ),
                      SizedBox(
                        height: AppDimens.height20,
                      ),
                      FormFieldWithPrefixIcon(
                        controller: bioController,
                        hintText: LocalStrings.enterBio,maxLength: 250,
                        maxLines: 3,
                        focusNode: FocusNode(),
                      ),
                      SizedBox(
                        height: AppDimens.height20,
                      ),
                      Text(
                        LocalStrings.socialInfo,
                        style: AppStyle.influencerProfileTextStyle,
                      ),
                      SizedBox(
                        height: AppDimens.height5,
                      ),
                      FormFieldWithPrefixIcon(
                        controller: instagramController,
                        hintText: LocalStrings.enterInstagramLink,
                        focusNode: FocusNode(),
                        needValidation: true,
                        isInstagramURLValidator: true,
                        image: AppImage.instagram,
                        prefixIcon: true,
                      ),
                      SizedBox(
                        height: AppDimens.height20,
                      ),
                      FormFieldWithPrefixIcon(
                        controller: tikTokController,
                        hintText: LocalStrings.enterTiktokLink,
                        focusNode: FocusNode(),
                        image: AppImage.tiktok,
                        needValidation: true,
                        isTiktokURLValidator: true,
                        prefixIcon: true,
                      ),
                      SizedBox(
                        height: AppDimens.height20,
                      ),
                      FormFieldWithPrefixIcon(
                        controller: facebookController,
                        hintText: LocalStrings.enterFacebookLink,
                        focusNode: FocusNode(),
                        needValidation: true,
                        isFacebookURLValidator: true,
                        image: AppImage.facebook,
                        prefixIcon: true,
                      ),
                      SizedBox(
                        height: AppDimens.height20,
                      ),
                      FormFieldWithPrefixIcon(
                        controller: youtubeController,
                        hintText: LocalStrings.enterYouTubeLink,
                        focusNode: FocusNode(),
                        image: AppImage.youtube,
                        prefixIcon: true,
                      ),
                      SizedBox(
                        height: AppDimens.height30,
                      ),
                      RoundButton(
                          color: Colors.transparent,
                          textColor: AppColors.color000000,
                          text: LocalStrings.doneButtonText,
                          onPressedFunction: () {
                            if (numberController.text.isEmpty &&
                                provider.gender!.isEmpty &&
                                dobController.text.isEmpty &&
                                bioController.text.isEmpty) {
                              FlushBarMessage.flushBarBottomErrorMessage(
                                  message: LocalStrings.pleaseEnterCredential,
                                  context: context);
                            } else if (numberController.text.isEmpty) {
                              FlushBarMessage.flushBarBottomErrorMessage(
                                  message: LocalStrings.pleaseEnterPhoneNumber,
                                  context: context);
                            } else if (provider.gender!.isEmpty) {
                              FlushBarMessage.flushBarBottomErrorMessage(
                                  message: LocalStrings.pleaseSelectGender,
                                  context: context);
                            } else if (dobController.text.isEmpty) {
                              FlushBarMessage.flushBarBottomErrorMessage(
                                  message: LocalStrings.dateOfBirth,
                                  context: context);
                            } else if (bioController.text.isEmpty) {
                              FlushBarMessage.flushBarBottomErrorMessage(
                                  message: LocalStrings.pleaseEnterBio,
                                  context: context);
                            }else
                            {
                              provider.completeInfluencerProfile(
                                  bio: bioController.text,
                                  image: provider.influencerImage,
                                  context: context,
                                  facebookLink: facebookController.text,
                                  instagramLink: instagramController.text,
                                  tiktokLink: tikTokController.text,
                                  youtubeLink: youtubeController.text,
                                  mobile: numberController.text,
                                  gender:provider.gender,
                                  dateOfBirth: dobController.text);
                            }
                          }),
                      SizedBox(
                        height: AppDimens.height20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
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
