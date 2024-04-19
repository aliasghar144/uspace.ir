import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfPayScreen extends StatelessWidget {
  const ConfPayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? resCode = Get.parameters['orderCode'];
    String? code = Get.parameters['payStatus'];
    return Scaffold(
      appBar: AppBar(
        title: Text('pay done'),
      ),
      body: Column(
        children: [
          Text('thats it'),
          Text('it is status code $code'),
          SizedBox(height: 200,),
          Text('thats it'),
          Text('it is status code $resCode'),
        ],
      ),
    );
  }
}
