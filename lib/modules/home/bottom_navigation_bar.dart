import 'package:foodie_connect/core_utils/export_dependency.dart';
import 'package:foodie_connect/modules/home/provider/home_provider.dart';
import 'package:foodie_connect/modules/home/qr_scanner/screens/qr_screen.dart';
import 'package:foodie_connect/routes/routes_export.dart';

import 'deals/exclusive_deals/exclusive_deals.dart';
import 'deals/public_deals/public_deals.dart';
import 'deals/unpublish_deals/unpublished_deal_information.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  final pages = [
    const PublicDeals(),
    const ExclusiveDeals(),
    const QRScannerScreen(),
    const UnpublishedDealsInformation(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context,provider,child) {
        return Scaffold(
          body: pages[provider.pageIndex],
          bottomNavigationBar: Container(
            height: AppDimens.height70,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    spreadRadius: AppDimens.radius5,
                    blurStyle: BlurStyle.inner,
                    color: Colors.black12)
              ],
              color: Colors.white,
            ),
            child:Padding(
              padding:  EdgeInsets.only(top: AppDimens.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        provider.setPageIndex(0);
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.asset(
                              AppImage.publicDeals,
                              height: AppDimens.height30,
                              width: AppDimens.width30,
                              color: provider.pageIndex == 0
                                  ? AppColors.color000000
                                  : Colors.black45,
                            ),
                            Text(
                              LocalStrings.publicDeals,
                              style: provider.pageIndex == 0
                                  ? AppStyle.bottomNavigationSelectdStyle
                                  : AppStyle.bottomNavigationStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        provider.setPageIndex(1);
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.asset(
                              AppImage.exclusiveDeals,
                              height: AppDimens.height30,
                              width: AppDimens.width30,
                              color: provider.pageIndex == 1
                                  ? AppColors.color000000
                                  : Colors.black45,
                            ),
                            Text(
                              LocalStrings.exclusive,
                              style: provider.pageIndex == 1
                                  ? AppStyle.bottomNavigationSelectdStyle
                                  : AppStyle.bottomNavigationStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        provider.setPageIndex(2);
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.asset(
                              AppImage.scanIcon,
                              height: AppDimens.height30,
                              width: AppDimens.width30,
                              color: provider.pageIndex == 2
                                  ? AppColors.color000000
                                  :Colors.black45,
                            ),
                            Text(
                              LocalStrings.scan,
                              style: provider.pageIndex == 2
                                  ? AppStyle.bottomNavigationSelectdStyle
                                  : AppStyle.bottomNavigationStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        provider.setPageIndex(3);
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.asset(
                              AppImage.settingIcon,
                              height: AppDimens.height30,
                              width: AppDimens.width30,
                              color: provider.pageIndex == 3
                                  ? AppColors.color000000
                                  : Colors.black45,
                            ),
                            Text(
                              LocalStrings.settings,
                              style: provider.pageIndex == 3
                                  ? AppStyle.bottomNavigationSelectdStyle
                                  : AppStyle.bottomNavigationStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
