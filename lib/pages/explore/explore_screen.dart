import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Center(child: Text('explore Screen',style:Theme.of(context).textTheme.headlineMedium))
        ]
    );
  }
}
