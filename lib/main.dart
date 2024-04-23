import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uspace_ir/app/config/them_data.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/routes/route.dart';
import 'package:uspace_ir/services/uni_services.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  await UniServices.init();

  await Hive.initFlutter();
  await Hive.openBox(userBox);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
      ScreenUtilInit(
        builder: (BuildContext context, Widget? child) {
    return GetMaterialApp(
        theme: ThemConfig.createTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        getPages: Pages().pages
    );
  },)
  );
}