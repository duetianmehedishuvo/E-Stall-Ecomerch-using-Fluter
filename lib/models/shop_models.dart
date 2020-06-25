class ShopModels{
  String name;

  ShopModels({this.name});

  Map<String,dynamic> tomap(){
    final map=<String,dynamic>{
      'ShopName':name
    };
    return map;
  }

  ShopModels.formMap(Map<String,dynamic> map){
    name=map['ShopName'];
  }

}