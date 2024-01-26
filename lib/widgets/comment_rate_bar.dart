import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';


Widget RateStar({
  String? point,
  required String title,
}){
  return Tooltip(
    triggerMode: TooltipTriggerMode.tap,
    message: title,
    textStyle: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color:Colors.white),
    child: ShaderMask(blendMode: BlendMode.srcATop,
        shaderCallback: (Rect rect) {
          return LinearGradient(
            stops: [0, int.parse(point??'0') / 10, int.parse(point??'0') / 10],
            colors: [const Color(0xffFFC700), const Color(0xffFFC700), const Color(0xffFFC700).withOpacity(0)],
          ).createShader(rect);
        },
        child:const SizedBox(
          width: 15,
          height: 15,
          child: Icon(Icons.star_rounded, size: 15, color: AppColors.grayColor),
        )),
  );
}