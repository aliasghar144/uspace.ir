import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';

class RoomReservationController extends GetxController{

  final RxInt dropdownValue = 1.obs;

  dropDownItems({required int loop,required String? unit}){
    List<DropdownMenuItem<int>> list = [];
    for(int i = 1 ; i<=loop ; i++){
      list.add(DropdownMenuItem(
          value: i,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'تعداد $unit:',
                      style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                    ),
                    TextSpan(
                      text: ' $i',
                      style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                    )
                  ])),
            ],
          )));
      print(i);
    }
    return list;
  }

  final numberOfRoom = '1'.obs;

  final List<String> numberOfRoomItems = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

}