import 'package:estallecomerch/models/payment_product_models.dart';
import 'package:estallecomerch/models/profile.dart';

class PaymentModels{

  String paymentMethod;
  String transactionNumber;
  num price;
  num count;
  Profile profile;
  List<PaymentProductModels> paymentProductModels;

  PaymentModels({this.paymentMethod, this.transactionNumber, this.price, this.count});

  Map<String ,dynamic> toMap(){
    final map=<String,dynamic>{
      'Payment_method':paymentMethod,
      'Transaction_Number':transactionNumber,
      'Total_Price':price,
      'Total_count':count,
      'profile':profile.toMap(),
      'products':paymentProductModels.map((product) => product.tomap()).toList(),
    };
    return map;
  }

  PaymentModels.fromMap(Map<String,dynamic> map){
    paymentMethod=map['Payment_method'];
    transactionNumber=map['Transaction_Number'];
    price=map['Total_Price'];
    count=map['Total_count'];
    profile=Profile.fromMap(map['profile']);
    paymentProductModels= List<PaymentProductModels>.from(map["products"].map((x) => PaymentProductModels.fromMap(x)));
  }

}