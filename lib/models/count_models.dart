class CountModels{
  num count;
  double price;
  String email;
  String keyName;

  CountModels({this.count, this.price,this.email,this.keyName});

  @override
  String toString() {
    return 'CountModels{count: $count, price: $price}';
  }

  Map<String,dynamic> counttoMap(){
    var map=<String,dynamic>{
      'count':count,
      'price':price,
      'email':email,
      'keyName':keyName
    };
    return map;
  }

  CountModels.fromMap(Map<String,dynamic> map){
    count=map['count'];
    price=map['price'];
    email=map['email'];
    keyName=map['keyName'];
  }

}