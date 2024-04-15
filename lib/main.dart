import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uspace_ir/app/config/them_data.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/routes/route.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(userBox);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
      ScreenUtilInit(
        builder: (BuildContext context, Widget? child) {
    return GetMaterialApp(
        localizationsDelegates: const [
          // this line is important
          RefreshLocalizations.delegate,
        ],
        theme: ThemConfig.createTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.home,
        getPages: Pages().pages
    );
  },)
  );
}