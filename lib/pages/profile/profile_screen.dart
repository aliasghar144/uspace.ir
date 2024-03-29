import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  // final LoginController loginController = Get.find();

  ScrollController  scrollController = ScrollController();

  var containerKey = GlobalKey();
  var container2Key = GlobalKey();
  var container3Key = GlobalKey();
  var container4Key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Scrollable.ensureVisible(          container4Key.currentContext!,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,);
                  scrollController.position.animateTo(index.toDouble(), duration: Duration(seconds: 1), curve: Curves.linear);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(index.toString()),),
              );
            },),
          ),
          Container(
            key: containerKey,
            height: 50,
            color:Colors.blue,
            child: Column(
              children: [
                Text('be nam god')
              ],
            ),
          ),
          SizedBox(height:800),
          Container(
            key: container2Key,
            height: 50,
            color:Colors.red,
            child: Column(
              children: [
                Text('be nam god')
              ],
            ),
          ),
          SizedBox(height:800),
          Container(
            key: container3Key,
            height: 50,
            color:Colors.blue,
            child: Column(
              children: [
                Text('be nam god')
              ],
            ),
          ),
          SizedBox(height:800),
          Container(
            key: container4Key,
            height: 50,
            color:Colors.red,
            child: Column(
              children: [
                Text('be nam god')
              ],
            ),
          ),
          SizedBox(height:800),
        ],
      ),
    );
  }

}
