import 'package:uni_links/uni_links.dart';

class UniServices{
  static init()async{
    try{
      final Uri? uri = await getInitialUri();
      uniHandler(uri);
    } catch(e){
      print('Errror =========>$e');
    }
   uriLinkStream.listen((Uri? uri) async{
     uniHandler(uri);
   },onError: (erorr){
     print('uni link error is : $erorr');
   });
  }

  static uniHandler(Uri? uri){
    if(uri == null || uri.queryParameters.isEmpty) {
      print('this is uni handler$uri');
      print('this is uni handler parametrs is ${uri?.queryParameters}');
      print('this is uni handler data is${uri?.data}');
      print('this is uni handler query is${uri?.query}');
      return ;
    }
    print('uri is ${uri.queryParameters}');
  }

}