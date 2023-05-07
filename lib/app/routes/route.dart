class Pages{

  final pages = [
    GetPage(name: Routes.initial, page:() => SplashScreen()),
    GetPage(name: Routes.home, page:() =>  BasePage(),/*middlewares: [AuthMiddleware()]*/),
    GetPage(name: Routes.signUp, page:() => SignUpScreen(),),
    GetPage(name: Routes.signIn, page:() => SignInScreen(),transition: Transition.fadeIn),
    GetPage(name: Routes.signInWithPassword, page:() => SignInWithPasswordScreen(),transition: Transition.fadeIn),
    GetPage(name: Routes.signInWithVerification, page:() =>  SignInWithVerification(),transition: Transition.fadeIn),
    GetPage(name: Routes.cart, page:() => CartScreen(),transition: Transition.fadeIn),
  ];

}