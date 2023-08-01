import 'package:flutter/material.dart';
import 'package:uspace_ir/app/widgets/bottom_sheets.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(onPressed: (){
            BottomSheets().loginBottomSheet();
          }, icon: Icon(Icons.add))
        ],
      ),
    );
  }

}
