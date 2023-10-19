import 'package:flutter/material.dart';
import '../core_utils/app_colors.dart';
import '../core_utils/app_dimens.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String image;
  final Color? color;
  final bool fillColorStatus;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function()? onTap;
  const CustomDatePicker(
      {Key? key,
      this.controller,
      this.color,
      this.hintText,
      required this.image,
      this.onTap,
      this.textInputAction,
      required this.focusNode,
      this.fillColorStatus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: AppDimens.height55,
        child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            readOnly: true,
            decoration: InputDecoration(
              prefixIconConstraints: BoxConstraints(
                maxHeight: AppDimens.height40,
                minHeight: AppDimens.height40,
                minWidth: AppDimens.height40,
              ),
              filled: true,
              fillColor: fillColorStatus
                  ? AppColors.color000000.withOpacity(0.2)
                  : AppColors.color3F3F3F,
              hintText: hintText,
              prefixIcon: Container(
                width: AppDimens.width50,
                margin: EdgeInsets.only(
                    right: AppDimens.width10,
                    top: AppDimens.height10,
                    bottom: AppDimens.height10),
                child: Image.asset(
                  image,
                  height: AppDimens.height15,
                  width: AppDimens.height15,
                  color: fillColorStatus
                      ? AppColors.color000000
                      : AppColors.color3F3F3F,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radius15),
                borderSide: BorderSide(
                  color: AppColors.whiteColor,
                ),
              ),
              contentPadding: EdgeInsets.all(AppDimens.height10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radius15),
                borderSide: BorderSide(
                  color: AppColors.whiteColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radius15),
                borderSide: BorderSide(
                  color: AppColors.redColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radius15),
                borderSide: BorderSide(
                  color: AppColors.redColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radius15),
                borderSide: BorderSide(
                  color: AppColors.color000000,
                ),
              ),
              focusColor: AppColors.color3F3F3F,
            ),
            onTap: onTap));
  }
}
