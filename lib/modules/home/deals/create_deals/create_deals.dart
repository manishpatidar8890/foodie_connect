import 'dart:io';

import 'package:foodie_connect/core_utils/export_dependency.dart';
import 'package:foodie_connect/modules/home/provider/deals_provider.dart';
import 'package:foodie_connect/widgets/round_button.dart';
import 'package:foodie_connect/widgets/text_form_field_with_prefix_icon_label.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../local_store/shared_preference.dart';
import '../../../../network/models/response/create_deals/create_deals.dart';
import '../../provider/create_provider.dart';

class CreateDealsScreen extends StatefulWidget {
  const CreateDealsScreen({super.key});

  @override
  State<CreateDealsScreen> createState() => _CreateDealsScreenState();
}

class _CreateDealsScreenState extends State<CreateDealsScreen> {
  DateTime firstDate = DateTime.now();
  TextEditingController firstDateController = TextEditingController();
  DateTime lastDate = DateTime.now();
  TextEditingController lastDateController = TextEditingController();
  FocusNode firstDateFocusNode=FocusNode();
  FocusNode lastDateFocusNode=FocusNode();

  Future<void> _selectFirstDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.black26, // <-- SEE HERE
                onPrimary: AppColors.color000000, // <-- SEE HERE
                onSurface: AppColors.color000000, // <-- SEE HERE
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
        initialDate: firstDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != firstDate) {
      setState(() {
        firstDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        print(formattedDate);
        firstDateController.text = formattedDate;
      });
    }
  }
  Future<void> _selectLastDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.black26, // <-- SEE HERE
                onPrimary: AppColors.color000000, // <-- SEE HERE
                onSurface: AppColors.color000000, // <-- SEE HERE
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
        initialDate: lastDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != lastDate) {
      setState(() {
        lastDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        print(formattedDate);
        lastDateController.text = formattedDate;
      });
    }
  }

  TextEditingController dealNameController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController spendingAmountController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocalStrings.createDeal,
          style: AppStyle.loginTitleTextStyle,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        // leading: const SizedBox(),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        bottom: false,
        child: Consumer<CreateProvider>(
          builder: (BuildContext context, provider, Widget? child) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppDimens.width15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () async {
                              XFile? image = await pickImage(context: context);
                              provider.setCreateDealImage(image!);
                            },
                            splashFactory: NoSplash.splashFactory,
                            child: showImage(provider.createImage)),
                      ],
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    FormFieldWithPrefixIcon(
                      focusNode: FocusNode(),
                      controller: dealNameController,
                      hintText: LocalStrings.enterDealName,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    FormFieldWithPrefixIcon(
                      focusNode: FocusNode(),
                      controller: customerController,
                      hintText: LocalStrings.customerBonus,
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    FormFieldWithPrefixIcon(
                      controller: spendingAmountController,
                      focusNode: FocusNode(),
                      hintText: LocalStrings.spendingAmount,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    FormFieldWithPrefixIcon(
                      focusNode: FocusNode(),
                      controller: feeController,
                      hintText: LocalStrings.feeForEachCustomer,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: FormFieldWithPrefixIcon(
                            focusNode: firstDateFocusNode,
                            image: AppImage.calenderIcon,
                            controller: firstDateController,
                            prefixIcon: true,
                            onTap: (){
                              _selectFirstDate(context);
                            },
                            hintText: LocalStrings.startDate,
                          ),
                        ),
                        SizedBox(
                          width: AppDimens.width10,
                        ),
                        Flexible(
                          child: FormFieldWithPrefixIcon(
                            focusNode: lastDateFocusNode,
                            prefixIcon: true,
                            onTap: (){
                              _selectLastDate(context);
                            },
                            controller: lastDateController,
                            image: AppImage.calenderIcon,
                            hintText: LocalStrings.endDate,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    FormFieldWithPrefixIcon(
                      focusNode: FocusNode(),
                      maxLines: 3,
                      controller: descriptionController,
                      hintText: LocalStrings.dealDescription,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocalStrings.exclusiveDeals,
                          style: AppStyle.forgetPassword,
                        ),
                        InkWell(
                            onTap: () {
                              if (provider.isExclusive == false) {
                                provider.setIsExclusive(true);
                              } else {
                                provider.setIsExclusive(false);
                              }
                            },
                            child: provider.isExclusive == false
                                ? Icon(
                                    Icons.toggle_off_outlined,
                                    color: Colors.black,
                                    size: AppDimens.height35,
                                  )
                                : Icon(
                                    Icons.toggle_on_outlined,
                                    color: Colors.black,
                                    size: AppDimens.height35,
                                  ))
                      ],
                    ),
                    provider.isExclusive == false
                        ? const SizedBox()
                        : SizedBox(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: AppDimens.height20,
                                ),
                                FormFieldWithPrefixIcon(
                                  focusNode: FocusNode(),
                                  image: AppImage.searchIcon,
                                  prefixIcon: true,
                                  hintText: LocalStrings.searchInfluencer,
                                ),
                                SizedBox(
                                  height: AppDimens.height5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          AppDimens.radius10),
                                      boxShadow: const [
                                        BoxShadow(
                                            spreadRadius: 1,
                                            blurStyle: BlurStyle.inner,
                                            blurRadius: 1)
                                      ]),
                                  height: AppDimens.height200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: provider.searchInfluencer.length,
                                    itemBuilder: (context, index) {
                                      return searchInfluencerList(
                                          data:
                                              provider.searchInfluencer[index],
                                          onTap: () {
                                            provider.setAddInfluencer(provider
                                                .searchInfluencer[index]);
                                          });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: AppDimens.height20,
                                ),
                                Text(
                                  LocalStrings.influencer,
                                  style: AppStyle.dealInfoStyle,
                                ),
                                SizedBox(
                                  height: AppDimens.height5,
                                ),
                                provider.addInfluencer.isEmpty
                                    ? const SizedBox()
                                    : SizedBox(
                                        height: AppDimens.height140,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount:
                                              provider.addInfluencer.length,
                                          itemBuilder: (context, index) {
                                            return influencerList(
                                                data: provider
                                                    .addInfluencer[index],
                                                onTap: () {
                                                  provider.setRemoveInfluencer(
                                                      index);
                                                });
                                          },
                                        ),
                                      )
                              ],
                            ),
                          ),
                    RoundButton(
                        color: Colors.transparent,
                        textColor: AppColors.color000000,
                        text: LocalStrings.saveDealButtonText,
                        onPressedFunction: () {
                          agreement();
                        }),
                    SizedBox(
                      height: AppDimens.height10,
                    ),
                    RoundButton(
                        color: Colors.transparent,
                        textColor: AppColors.color000000,
                        text: LocalStrings.saveDealPublishButtonText,
                        onPressedFunction: () {
                          PreferenceUtils.clearPreferences();
                        }),
                  ],
                ),
              ),
            );
          },
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

  Widget influencerList({
    required Datum data,
    required Function() onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: AppDimens.width10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          data.image.toString() == "null"
              ? Container(
                  height: AppDimens.height50,
                  width: AppDimens.width50,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(image: AssetImage(AppImage.dummy)),
                      borderRadius: BorderRadius.circular(AppDimens.radius50)),
                )
              : Container(
                  height: AppDimens.height50,
                  width: AppDimens.width50,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(image: NetworkImage(data.image)),
                      borderRadius: BorderRadius.circular(AppDimens.radius50)),
                ),
          SizedBox(
            height: AppDimens.height5,
          ),
          Text(
            "${data.firstName} ${data.lastName}",
            style: AppStyle.forgetPassword,
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              LocalStrings.remove,
              style: AppStyle.removeButton,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchInfluencerList({
    required Datum data,
    required Function() onTap,
  }) {
    return Padding(
      padding: EdgeInsets.all(AppDimens.height5),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                data.image.toString() == "null"
                    ? Container(
                        height: AppDimens.height30,
                        width: AppDimens.width30,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            image: const DecorationImage(
                                image: AssetImage(AppImage.dummy)),
                            borderRadius:
                                BorderRadius.circular(AppDimens.radius50)),
                      )
                    : Container(
                        height: AppDimens.height30,
                        width: AppDimens.width30,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            image: DecorationImage(
                                image: NetworkImage(data.image)),
                            borderRadius:
                                BorderRadius.circular(AppDimens.radius50)),
                      ),
                SizedBox(
                  width: AppDimens.width5,
                ),
                Text(
                  "${data.firstName} ${data.lastName}",
                  style: AppStyle.forgetPassword,
                ),
              ],
            ),
            Radio(
              value: "value",
              groupValue: "groupValue",
              onChanged: (value) {},
            )
          ],
        ),
      ),
    );
  }

  agreement() {
    return showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(AppDimens.width20),
          child: Container(
            padding: EdgeInsets.only(
                left: AppDimens.width10,
                right: AppDimens.width10,
                top: AppDimens.height30,
                bottom: AppDimens.width10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocalStrings.agreement,
                      style: AppStyle.pinCodeStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: AppDimens.height20,
                ),
                Text(
                  LocalStrings.dealDescriptionDummy,
                  style: AppStyle.dealInfoStyle,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: TextButton(
                          child: Text(
                            LocalStrings.cancelButtonText,
                            style: AppStyle.hintTextStyle,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppDimens.width10,
                    ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        width: double.maxFinite,
                        child: TextButton(
                          child: Text(
                            LocalStrings.acceptButtonText,
                            style: AppStyle.hintTextStyle,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
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
    );
  }
}
