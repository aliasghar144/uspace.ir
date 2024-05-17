import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

customProgress({
  required String footer,
  required String centerText,
  required Color startColor,
  required Color endColor,
  required double percent,
  double? radius,
  double? fontSize,
  double? width,
}) {
  return Column(

    children: [
      SizedBox(
        width: width,
        child: CircularPercentIndicator(
          center: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: const Color(0xff9e9e9e).withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 30,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ]),
              child: Text(
                centerText,
                style: Theme.of(Get.context!).textTheme.displaySmall!.copyWith(color: const Color(0xff737373),fontSize: fontSize),
              )),
          radius: radius ?? 40,
          reverse: true,
          circularStrokeCap: CircularStrokeCap.round,

          footer: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(footer, style: Theme.of(Get.context!).textTheme.labelSmall,maxLines: 2,textAlign: TextAlign.center,),
          ),
          percent: percent,
          lineWidth: 3,
          backgroundColor: const Color(0xffcbccc466).withOpacity(0.3),
          startAngle: 180,
          linearGradient: LinearGradient(colors: [endColor, startColor]),
        ),
      ),
    ],
  );
}