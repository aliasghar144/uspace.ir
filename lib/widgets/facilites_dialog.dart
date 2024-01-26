
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';


 Dialog facilityDialog({
  required String title,
   required int hasBrakeFast,
   required int hasDinner,
   required int hasLunch,
   List<RoomFeature>? feature,
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
                    border: Border.all(width: 0.1,color: hasLunch == 1 ?AppColors.mainColor:AppColors.grayColor),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(hasLunch == 1 ?'شام دارد':'شام ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: hasLunch == 1 ? AppColors.mainColor : AppColors.grayColor)),
                    const SizedBox(width: 2),
                    SvgPicture.asset('assets/icons/lunch_ic.svg',color: hasLunch == 1 ?AppColors.mainColor:AppColors.grayColor),
                  ]),
                ),
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0.1,color: hasDinner == 1 ? AppColors.mainColor:AppColors.grayColor),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(hasDinner == 1 ? 'نهار دارد' : 'نهار ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: hasDinner == 1 ? AppColors.mainColor:AppColors.grayColor)),
                    const SizedBox(width: 2),
                    SvgPicture.asset('assets/icons/dinner_ic.svg',color: hasDinner == 1 ? AppColors.mainColor:AppColors.grayColor),
                  ]),
                ),
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0.1,color: hasBrakeFast == 1 ? AppColors.mainColor:AppColors.grayColor),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text( hasBrakeFast == 1 ? 'صبحانه دارد': 'صبحانه ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: hasBrakeFast == 1 ? AppColors.mainColor : AppColors.grayColor)),
                    const SizedBox(width: 2),
                    SvgPicture.asset('assets/icons/breakfast_ic.svg',color: hasBrakeFast == 1 ? AppColors.mainColor : AppColors.grayColor,),
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
              itemCount: feature?.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.19, mainAxisExtent: null),
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    feature![index].feature.image == null ?
                    const Icon(Icons.done_rounded,size: 10,color:AppColors.mainColor,):
                    feature[index].feature.image!.startsWith('fa') ? Icon(Icons.star,size: 10,color: Colors.yellow,) : Icon(Icons.done,size: 10,),
                    const SizedBox(width: 5),
                    Flexible(
                        child: Text(
                          feature[index].feature.title,
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