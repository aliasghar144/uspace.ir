

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/them_data.dart';
import 'package:uspace_ir/app/routes/constance_routes.dart';
import 'package:uspace_ir/app/routes/route.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
      theme: ThemConfig.createTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      getPages: Pages().pages
  ));
}