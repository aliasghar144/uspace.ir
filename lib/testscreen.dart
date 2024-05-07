import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  TestScreen({Key? key}) : super(key: key);

  PageController pageController  = PageController(initialPage: 0,keepPage: false,);

  GlobalKey page2key = GlobalKey();
  GlobalKey page1key = GlobalKey();
  GlobalKey page3key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

        length: 3, child: Scaffold(
      body: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                IconButton(onPressed: (){
                }, icon: Icon(Icons.padding)),
                Text('data'),
              ],
            ),
          )
        ];
      }, body: PageView(
        pageSnapping: false,
        controller: pageController,
        scrollDirection: Axis.vertical,
        allowImplicitScrolling: true,
        padEnds: false,
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            height: 4500,
            color:Colors.red,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                ],
              ),
            ),
          ),
          Container(
            height: 1000,
            color:Colors.yellow,
          ),
          Container(
            height: 1000,
            color:Colors.black54,
          ),
        ],
      ),
      ),
    ));
  }
}
