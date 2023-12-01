
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';


 Dialog facilityDialog({
  required String title,
   required bool hasBrakeFast,
   required bool hasDinner,
   required bool hasLunch,
}){
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 25),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
      Stack(alignment: Alignment.center, children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
              splashRadius: 20,
              onPressed: () {
                Get.close(1);
              },
              icon: const Icon(Icons.cancel_outlined, color: Colors.grey, size: 15)),
        ),
        Text('امکانات', style: Theme.of(Get.context!).textTheme.bodyLarge),
      ]),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(children: [
          Text(title, style: Theme.of(Get.context!).textTheme.labelSmall),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 5),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0.1,color: hasLunch?AppColors.mainColor:AppColors.grayColor),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(hasLunch?'شام دارد':'شام ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: hasLunch ? AppColors.mainColor : AppColors.grayColor)),
                    const SizedBox(width: 2),
                    SvgPicture.asset('assets/icons/lunch_ic.svg',color: hasLunch?AppColors.mainColor:AppColors.grayColor),
                  ]),
                ),
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0.1,color: hasDinner ? AppColors.mainColor:AppColors.grayColor),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(hasDinner ? 'نهار دارد' : 'نهار ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: hasDinner ? AppColors.mainColor:AppColors.grayColor)),
                    const SizedBox(width: 2),
                    SvgPicture.asset('assets/icons/dinner_ic.svg',color: hasDinner ? AppColors.mainColor:AppColors.grayColor),
                  ]),
                ),
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0.1,color: hasBrakeFast ? AppColors.mainColor:AppColors.grayColor),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text( hasBrakeFast ? 'صبحانه دارد': 'صبحانه ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: hasBrakeFast ? AppColors.mainColor : AppColors.grayColor)),
                    const SizedBox(width: 2),
                    SvgPicture.asset('assets/icons/breakfast_ic.svg',color: hasBrakeFast ? AppColors.mainColor : AppColors.grayColor,),
                  ]),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
          const Divider(
            thickness: 0.2,
            color: Colors.black,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: GridView.builder(
              itemCount: 15,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.19, mainAxisExtent: null),
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/bed_ic.svg'),
                    const SizedBox(width: 5),
                    Flexible(
                        child: Text(
                          'تخت دبل',
                          style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey),
                          textAlign: TextAlign.right,
                        )),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 15),
        ]),
      ),
    ]),
  );
}