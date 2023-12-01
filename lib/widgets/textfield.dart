import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final int? length;
  final int? maxline;
  final IconButton? iconButton;
  final double verticalScrollPadding;
  final TextInputAction? textInputAction;
  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final List<FilteringTextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final GestureTapCallback? onEditingComplete;
  final FocusNode? focusNode;

  MyTextField({required this.label, this.iconButton, this.hintText, this.length, this.verticalScrollPadding = 0.0, this.focusNode, this.onEditingComplete, this.validator, this.textInputAction, this.maxline, this.keyboardType, this.inputFormatters, required this.textEditingController, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        scrollPadding: EdgeInsets.zero,
        validator: validator,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        maxLines: maxline,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLength: length,
        inputFormatters: inputFormatters,
        controller: textEditingController,
        onEditingComplete: onEditingComplete,
        style: Theme.of(Get.context!).textTheme.labelLarge,
        decoration: InputDecoration(
          floatingLabelStyle: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
          hintText: hintText,
          hintStyle: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.grayColor),
          fillColor: Colors.white,
          filled: true,
          counterText: '',
          labelStyle: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.grayColor),
          suffixIcon: iconButton,
          labelText: label,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: verticalScrollPadding),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.grayColor, width: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.grayColor, width: 0.5), borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.mainColor, width: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ));
  }
}
