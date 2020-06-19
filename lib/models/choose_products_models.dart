import 'package:estallecomerch/models/products_models.dart';

class ChooseProductModels{

  String imageUrl;
  String nameKey;
  double current_price;
  double last_price;
  String category;
  String description;
  String condition;
  String name;
  String quantity;
  String authorName;
  int count;
  double totalPrice;

  ChooseProductModels({
    this.imageUrl,
    this.current_price,
    this.last_price,
    this.category,
    this.description,
    this.condition,
    this.name,
    this.quantity,
    this.authorName='estall',
    this.nameKey,
    this.count,
    this.totalPrice,
  });


  @override
  String toString() {
    return 'ChooseProductModels{imageUrl: $imageUrl, nameKey: $nameKey, current_price: $current_price, last_price: $last_price, category: $category, description: $description, condition: $condition, name: $name, quantity: $quantity, authorName: $authorName, count: $count, totalPrice: $totalPrice}';
  }

  Map<String,dynamic> toMap() {
    var map=<String,dynamic>{
      'name':name,
      'imageUrl':imageUrl,
      'Current_price':current_price,
      'last_price':last_price,
      'category':category,
      'description':description,
      'condition':condition,
      'quantity':quantity,
      'author-name':authorName,
      'name_key':nameKey,
      'count':count,
      'pTotalPrice':totalPrice,
    };

    return map;
  }

  ChooseProductModels.fromMap(Map<String,dynamic> map){
    name=map['name'];
    imageUrl=map['imageUrl'];
    current_price=map['Current_price'];
    last_price=map['last_price'];
    category=map['category'];
    description=map['description'];
    condition=map['condition'];
    quantity=map['quantity'];
    authorName=map['author-name'];
    nameKey=map['name_key'];
    count=map['count'];
    totalPrice=map['pTotalPrice'];
  }
}