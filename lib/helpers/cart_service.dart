
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estallecomerch/models/choose_products_models.dart';
import 'package:estallecomerch/models/products_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

final COLLECTION_PRODUCTS_CHOOSE='products_choose';

class CartService{

  static final Firestore db=Firestore.instance;


  static Future addtocartProduct(ChooseProductModels chooseProductModels,String email)async{
    final doc= db.collection(COLLECTION_PRODUCTS_CHOOSE).document(email).collection('Products').document(chooseProductModels.nameKey);
    return await doc.setData(chooseProductModels.toMap());
  }

  static Future removetocartProduct(ChooseProductModels chooseProductModels,String email)async{
    final doc= db.collection(COLLECTION_PRODUCTS_CHOOSE).document(email).collection('Products').document(chooseProductModels.nameKey);
    return await doc.delete();
  }

  static Future<List<ChooseProductModels>> getAllChooseProducts(String email)async{
    QuerySnapshot snapshot=await db.collection(COLLECTION_PRODUCTS_CHOOSE).document(email).collection('Products').getDocuments();

    if(snapshot!=null){
      return snapshot.documents.map((chooseProducts) => ChooseProductModels.fromMap(chooseProducts.data)).toList();
    }
  }

  static Future addtocartProductDelete(String nameKey,String email)async{
    final doc= db.collection(COLLECTION_PRODUCTS_CHOOSE).document(email).collection('Products').document(nameKey);
    return await doc.delete();
  }



}