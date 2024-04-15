import 'package:uspace_ir/models/order_model.dart';

payPriceCalculate(List<DayAndPrice> days) {
  int payPrice = 0;
  for (DayAndPrice dayAndPrice in days) {
    payPrice += dayAndPrice.originalPrice;
  }
  return payPrice;
}
