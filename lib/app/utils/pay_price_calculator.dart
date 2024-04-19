import 'package:uspace_ir/models/order_model.dart';

payPriceCalculate(List<DayAndPrice> days,bool offer) {
  int payPrice = 0;
  if(offer){
    for (DayAndPrice dayAndPrice in days) {
      payPrice += dayAndPrice.priceWithDiscount;
    }
  }else{
    for (DayAndPrice dayAndPrice in days) {
      payPrice += dayAndPrice.originalPrice;
    }
  }
  return payPrice;
}
