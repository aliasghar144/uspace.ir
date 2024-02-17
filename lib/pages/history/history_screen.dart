import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Center(child: Text('History Screen',style:Theme.of(context).textTheme.headlineMedium)),
        IconButton(onPressed: (){
          Get.dialog(
              Dialog(

            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.white,child: Expanded(child: Container(
            color: Colors.red,
          ),),));
        }, icon: Icon(Icons.add))
      ]
    );
  }
}
