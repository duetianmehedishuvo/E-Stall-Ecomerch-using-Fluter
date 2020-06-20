class ProductsUserId{
  String imageUrl;
  String nameKey;
  num current_price;
  num last_price;
  String category;
  String description;
  String condition;
  String name;
  String quantity;
  String authorName;
  num count;
  num price;
  bool favouriteCheck;

  ProductsUserId({
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
    this.price,
    this.count,
    this.favouriteCheck,
  });


  @override
  String toString() {
    return 'Products{imageUrl: $imageUrl, current_price: $current_price, last_price: $last_price, category: $category, description: $description, condition: $condition, name: $name, quantity: $quantity, authorName: $authorName}';
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
      'price':price,
      'favourite_check':favouriteCheck,
    };

    return map;
  }

  ProductsUserId.fromMap(Map<String,dynamic> map){
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
    price=map['price'];
    favouriteCheck=map['favourite_check'];
  }

}