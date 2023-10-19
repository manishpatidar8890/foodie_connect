import 'package:foodie_connect/core_utils/export_dependency.dart';
import 'package:foodie_connect/widgets/round_button.dart';
import 'package:foodie_connect/widgets/text_form_field_with_prefix_icon_label.dart';
import 'package:provider/provider.dart';
import '../../provider/deals_provider.dart';

class PublicDealsInformation extends StatefulWidget {
  const PublicDealsInformation({super.key});

  @override
  State<PublicDealsInformation> createState() => _PublicDealsInformationState();
}

class _PublicDealsInformationState extends State<PublicDealsInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocalStrings.publicDealsInformation,
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
        child: Consumer<DealsProvider>(
          builder:
              (BuildContext context, DealsProvider provider, Widget? child) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppDimens.width15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: AppDimens.width5),
                      height: AppDimens.height180,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppDimens.radius10),
                          border: Border.all(color: AppColors.color000000)),
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    Text(
                      "Burger Shake",
                      style: AppStyle.dealTitleStyle,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocalStrings.startDate,
                                  style: AppStyle.dealInfoStyle,
                                ),
                                SizedBox(
                                  height: AppDimens.height5,
                                ),
                                Text(
                                  "25 sep",
                                  style: AppStyle.buttonTextTextTextStyle,
                                ),
                                SizedBox(
                                  height: AppDimens.height20,
                                ),
                                Text(
                                  LocalStrings.spendingAmount,
                                  style: AppStyle.dealInfoStyle,
                                ),
                                SizedBox(
                                  height: AppDimens.height5,
                                ),
                                Text(
                                  "\$ 1,200",
                                  style: AppStyle.buttonTextTextTextStyle,
                                ),
                                SizedBox(
                                  height: AppDimens.height20,
                                ),
                                Text(
                                  LocalStrings.feeForEachCustomer,
                                  style: AppStyle.dealInfoStyle,
                                ),
                                SizedBox(
                                  height: AppDimens.height5,
                                ),
                                Text(
                                  "\$ 800",
                                  style: AppStyle.buttonTextTextTextStyle,
                                ),
                              ],
                            )),
                        Flexible(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  LocalStrings.endDate,
                                  style: AppStyle.dealInfoStyle,
                                ),
                                SizedBox(
                                  height: AppDimens.height5,
                                ),
                                Text(
                                  "25 sep",
                                  style: AppStyle.buttonTextTextTextStyle,
                                ),
                                SizedBox(
                                  height: AppDimens.height20,
                                ),
                                Text(
                                  LocalStrings.receivePercent,
                                  style: AppStyle.dealInfoStyle,
                                ),
                                SizedBox(
                                  height: AppDimens.height5,
                                ),
                                Text(
                                  "12%",
                                  style: AppStyle.buttonTextTextTextStyle,
                                ),
                                SizedBox(
                                  height: AppDimens.height20,
                                ),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    Text(
                      LocalStrings.dealDescription,
                      style: AppStyle.dealInfoStyle,
                    ),
                    SizedBox(
                      height: AppDimens.height5,
                    ),
                    Text(
                      LocalStrings.dealDescriptionDummy,
                      style: AppStyle.dealTitleStyle,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    Text(
                      LocalStrings.eachScan,
                      style: AppStyle.dealInfoStyle,
                    ),
                    SizedBox(
                      height: AppDimens.height5,
                    ),
                    Text(
                      "1 Point",
                      style: AppStyle.dealTitleStyle,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    Text(
                      LocalStrings.customersInfluenced,
                      style: AppStyle.dealInfoStyle,
                    ),
                    SizedBox(
                      height: AppDimens.height5,
                    ),
                    Text(
                      "132",
                      style: AppStyle.dealTitleStyle,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    RoundButton(
                        color: Colors.transparent,
                        textColor: AppColors.color000000,
                        text: LocalStrings.updateDealButtonText,
                        onPressedFunction: () {}),
                    SizedBox(
                      height: AppDimens.height10,
                    ),
                    RoundButton(
                        color: Colors.transparent,
                        textColor: AppColors.color000000,
                        text: LocalStrings.deleteDealButtonText,
                        onPressedFunction: () {}),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
