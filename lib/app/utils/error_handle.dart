import 'package:flutter/material.dart';

class ImageError{
  Widget imageError(){
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text("image couldn't load !!!",style:TextStyle(fontWeight: FontWeight.w600,fontSize:15),textDirection: TextDirection.ltr,),
        SizedBox(height: 5),
        Icon(Icons.error,size:25,color:Colors.red),
      ],
    ));
  }
}