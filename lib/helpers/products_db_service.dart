
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estallecomerch/models/count_models.dart';
import 'package:estallecomerch/models/products_models.dart';
import 'package:estallecomerch/models/products_models_user.dart';

final COLLECTION_PRODUCT='products';
final COLLECTION_USER='productsUser';

class ProductsDBService{

  static final Firestore db=Firestore.instance;

  //////////////////////Bello 3 Method for Product Insert/////////////////////////

  // Add a Single Products Items
  static Future addProduct(Products products)async{
    final doc= db.collection(COLLECTION_PRODUCT).document('All').collection('All').document('All').collection("All").document(products.nameKey);
    return await doc.setData(products.toMap());
  }

  static Future addProductWithUSER(ProductsUserId products,String email)async{
    final doc= db.collection(COLLECTION_USER).document('All').collection(email).document('All').collection("All").document(products.nameKey);
    return await doc.setData(products.toMap());
  }


  // Add a single Products but save Author File
  static Future addProductByAuthor(Products products)async{

    final doc1= db.collection(COLLECTION_PRODUCT).document('All').collection('Author').document(products.authorName).collection('Author').document(products.nameKey);

    return await doc1.setData(products.toMap());
  }

  static Future addProductByAuthorWithUser(ProductsUserId products,String email)async{

    final doc1= db.collection(COLLECTION_USER).document('All').collection(email).document('Author').collection(products.authorName).document(products.nameKey);

    return await doc1.setData(products.toMap());
  }


  static Future addFavouriteProductsWithUser(ProductsUserId products,String email)async{

    final doc1= db.collection(COLLECTION_USER).document('All').collection(email).document('Favourite').collection("Favourite").document(products.nameKey);

    return await doc1.setData(products.toMap());
  }

  // Add a single Products but save Author FileName
  static Future addProductByAuthorName(Products products)async{

    final doc1= db.collection(COLLECTION_PRODUCT).document('All').collection('AuthorName').document(products.authorName);

    return await doc1.setData(products.toMap());
  }

  static Future addProductByAuthorNameWithUser(ProductsUserId products,String email)async{

    final doc1= db.collection(COLLECTION_USER).document('AuthorName').collection(email).document(products.authorName);

    return await doc1.setData(products.toMap());
  }

  // Add a single Products but save category wise
  static Future addProductBYCategory(Products products)async{
    final doc= db.collection(COLLECTION_PRODUCT).document('All').collection('All').document('Category').collection(products.category).document(products.nameKey);
    return await doc.setData(products.toMap());
  }

  static Future addProductBYCategoryWithUser(ProductsUserId products,String email)async{
    final doc= db.collection(COLLECTION_USER).document('All').collection(email).document('Category').collection(products.category).document(products.nameKey);
    return await doc.setData(products.toMap());
  }

  /* Bellow Two Method  Get All Products Query with category Wise Search Query       */

  ////// get All Products Information
  static Future<List<Products>> getAllProducts() async{
    QuerySnapshot snapshot=await db.collection(COLLECTION_PRODUCT)
        .document('All')
        .collection('All')
        .document('All')
        .collection("All")
        .getDocuments();

    if(snapshot!=null){
      return snapshot.documents.map((products)=>Products.fromMap(products.data)).toList();
    }
  }

  static Future<List<ProductsUserId>> getAllProductsWithUser(String email) async{
    QuerySnapshot snapshot=await db.collection(COLLECTION_USER)
        .document('All')
        .collection(email)
        .document('All')
        .collection("All")
        .getDocuments();

    if(snapshot!=null){
      return snapshot.documents.map((products)=>ProductsUserId.fromMap(products.data)).toList();
    }
  }


  // Get All Auth Name Query
  static Future<List<ProductsUserId>> getAllAuthor(String shopName) async{

    QuerySnapshot snapshot=await db.collection(COLLECTION_PRODUCT)
        .document('All')
        .collection('Author')
        .document(shopName)
        .collection('Author')
        .getDocuments();

    if(snapshot!=null){
      return snapshot.documents.map((products)=>ProductsUserId.fromMap(products.data)).toList();
    }
  }

  static Future<List<ProductsUserId>> getAllAuthorWithUser(String shopName,String email) async{

    QuerySnapshot snapshot=await db.collection(COLLECTION_USER)
        .document('All')
        .collection(email)
        .document('Author')
        .collection(shopName)
        .getDocuments();

    if(snapshot!=null){
      return snapshot.documents.map((products)=>ProductsUserId.fromMap(products.data)).toList();
    }
  }

  static Future<List<ProductsUserId>> getAllFavouriteWithUser(String email) async{

    QuerySnapshot snapshot=await db.collection(COLLECTION_USER)
        .document('All')
        .collection(email)
        .document('Favourite')
        .collection('Favourite')
        .getDocuments();

    if(snapshot!=null){
      return snapshot.documents.map((products)=>ProductsUserId.fromMap(products.data)).toList();
    }
  }

  static Future removeAllFavouriteWithUser(ProductsUserId productsUserId,String email) async{

    final doc=await db.collection(COLLECTION_USER)
        .document('All')
        .collection(email)
        .document('Favourite')
        .collection('Favourite')
        .document(productsUserId.nameKey);

    return await doc.delete();
  }

  // Get All Auth Name Query
  static Future<List<Products>> getAllAuthorName() async{

    QuerySnapshot snapshot=await db.collection(COLLECTION_PRODUCT)
        .document('All')
        .collection('AuthorName')
        .getDocuments();

    if(snapshot!=null){
      return snapshot.documents.map((products)=>Products.fromMap(products.data)).toList();
    }
  }
//
//  //// get all Products but category wise
//  static Future<List<Products>> getAllProductsByCATEGORY(String category) async{
//    QuerySnapshot snapshot=await db.collection(COLLECTION_PRODUCT).document('All').collection('All').document('Category').collection(category).getDocuments();
//    if(snapshot!=null){
//      return snapshot.documents.map((products)=>Products.fromMap(products.data)).toList();
//    }
//  }
  //// get all Products but category wise
  static Future<List<ProductsUserId>> getAllProductsByCATEGORY(String category) async{
    QuerySnapshot snapshot=await db.collection(COLLECTION_USER).document('All').collection('All').document('Category').collection(category).getDocuments();
    if(snapshot!=null){
      return snapshot.documents.map((products)=>ProductsUserId.fromMap(products.data)).toList();
    }
  }

  static Future<List<ProductsUserId>> getAllProductsByCATEGORYINUSER(String category,String email) async{
    QuerySnapshot snapshot=await db.collection(COLLECTION_USER).document('All').collection(email).document('Category').collection(category).getDocuments();
    if(snapshot!=null){
      return snapshot.documents.map((products)=>ProductsUserId.fromMap(products.data)).toList();
    }
  }
}