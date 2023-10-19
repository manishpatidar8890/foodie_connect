import 'package:flutter/services.dart';
import 'package:foodie_connect/widgets/textfield_validation.dart';
import '../core_utils/export_dependency.dart';

class FormFieldWithPrefixIcon extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? image;
  final String? validationMessage;
  final Color? color;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool obscureValue;
  final bool passwordFilled;
  final bool isEmail;
  final bool isNumber;
  final bool? autoValidate;
  final bool needValidation;
  final bool isEmailValidator;
  final bool isInstagramURLValidator;
  final bool isFacebookURLValidator;
  final bool isTiktokURLValidator;
  final bool prefixIcon;
  final bool readOnly;
  final int? maxLength;
  final String ?validation;
  final int? maxLines;
  final VoidCallback? callBackFunction;
  final Function(String)? onFieldSubmitted;
  final Function()? onComplete;
  final Function()? onTap;
  final Function(String)? onChanged;
  const FormFieldWithPrefixIcon(
      {Key? key,
      this.controller,
        this.validation,
      this.color,
      this.hintText,this.onTap,
      this.onComplete,
      this.image,
      this.autoValidate,
      this.keyboardType,
      this.obscureValue = false,
      this.needValidation = false,
      this.isFacebookURLValidator = false,
      this.isTiktokURLValidator = false,
      this.isInstagramURLValidator = false,
      this.isEmailValidator = false,
      this.prefixIcon = false,
      this.passwordFilled = false,
      this.obscureText = false,
      this.isEmail = false,
      this.isNumber = false,
      this.callBackFunction,
      this.textInputAction,
      this.maxLength = 30,
      this.maxLines = 1,
      required this.focusNode,
      this.validationMessage,
      this.label,
      this.onFieldSubmitted,
      this.onChanged,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (label.isNotEmpty) Text(label, style: AppStyle.labelTextStyle),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          readOnly: readOnly,
          keyboardType: keyboardType,
          obscureText: obscureText,onTap: onTap,
          enableInteractiveSelection: false,
          maxLines: maxLines,
          onEditingComplete: onComplete,
          validator:isEmail?(value)=>validation: needValidation?(value) => TextFieldValidation.validation(
value: value,isFacebookURLValidator:isFacebookURLValidator,isInstagramURLValidator:isInstagramURLValidator,isTiktokURLValidator:isTiktokURLValidator,
            isEmailValidator:isEmailValidator,message: validationMessage):null,
          inputFormatters: [
            NoInitialSpaceInputFormatter(),
            LengthLimitingTextInputFormatter(maxLength),
            if (isEmail)
              FilteringTextInputFormatter.deny(
                RegExp(
                    r"\^|-|,|~| |`|#|\$|%|&|\*|_|:|;|\+|\(|\)|\{|\}|\[|\]|=|!|<|>|/|'|"),
              ),
            if(isNumber)
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          textInputAction: textInputAction,
          decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(
              maxHeight: AppDimens.height35,
              minHeight: AppDimens.height35,
              minWidth: AppDimens.width35,
            ),
            filled: true,
            fillColor: AppColors.colorEEEEEE,
            hintText: hintText,
            hintStyle: AppStyle.hintTextStyle,
            prefixIcon: prefixIcon == true
                ? Container(
                    width: AppDimens.width50,
                    margin: EdgeInsets.only(
                        right: AppDimens.width10,
                        top: AppDimens.height10,
                        bottom: AppDimens.height10),
                    decoration: BoxDecoration(
                      // border: Border(
                      //   right: BorderSide(
                      //     color: AppColors.dividerColor,
                      //     width: 1,
                      //   ),
                      // ),
                    ),
                    child: SizedBox(
                      child: Image.asset(
                        image!,
                        height: AppDimens.height15,
                        color: const Color(0XFF86878B),
                      ),
                    ),
                  )
                : null,
            suffixIcon: passwordFilled
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: GestureDetector(
                      onTap: callBackFunction,
                      child: Icon(
                        obscureValue
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                        color: obscureValue
                            ? AppColors.primaryColor
                            : AppColors.greyColor,
                      ),
                    ),
                  )
                :null,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: AppColors.color262626,
              ),
            ),
            contentPadding: EdgeInsets.only(left: AppDimens.width10,top: AppDimens.height10,bottom: AppDimens.height10),
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
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class NoInitialSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Prevent entering a space as the initial character
    if (newValue.text.startsWith(' ')) {
      return oldValue;
    }
    return newValue;
  }
}
