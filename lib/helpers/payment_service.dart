import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estallecomerch/models/payment_models.dart';
import 'package:estallecomerch/models/payment_product_models.dart';

final COLLECTION_PAYMENT='payment';
class PaymentService{

  static final Firestore db=Firestore.instance;

  static Future addPayment(PaymentModels paymentModels,String date,String time)async{

    final doc=db.collection(COLLECTION_PAYMENT).document(date).collection(paymentModels.profile.email).document(time).collection('collectionPath').document('userPayment');
    return await doc.setData(paymentModels.toMap());

  }

}