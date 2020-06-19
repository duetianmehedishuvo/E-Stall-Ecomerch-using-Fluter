import 'package:estallecomerch/helpers/cart_service.dart';
import 'package:flutter/cupertino.dart';

class ProductsProvider with ChangeNotifier{

  int _x=0;
   num _price=0;

  num get totalPrice=>_price;
  int get count=>_x;

  int getCount(String email){
    _x=0;
    CartService.getAllChooseProducts(email).then((prodcustList){
      prodcustList.forEach((element) {
        _x+=element.count;
        notifyListeners();
      });
      return _x;;
    });
  }

  num getTotalprice(String email){
    _price=0;
    CartService.getAllChooseProducts(email).then((prodcustList){
      prodcustList.forEach((element) {
        _price+=element.totalPrice;
        notifyListeners();
      });
      return _price;;
    });
  }

}