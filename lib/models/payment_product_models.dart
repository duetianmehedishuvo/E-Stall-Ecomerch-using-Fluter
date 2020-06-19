class PaymentProductModels{

  String name;
  num count;
  num current_price;
  num price;
  String authName;
  String keyName;

  PaymentProductModels({this.name, this.count, this.current_price, this.price,
      this.authName, this.keyName});

  Map<String,dynamic> tomap(){
    final map=<String,dynamic>{
      'name':name,
      'count':count,
      'Current_price':current_price,
      'Price':price,
      'authName':authName,
      'keyName':keyName,
    };
    return map;
  }

  PaymentProductModels.fromMap(Map<String,dynamic> map){
    name=map['name'];
    count=map['count'];
    current_price=map['Current_price'];
    price=map['Price'];
    authName=map['authName'];
    keyName=map['keyName'];
  }

}