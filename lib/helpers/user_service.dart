import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estallecomerch/models/contact_us_models.dart';
import 'package:estallecomerch/models/refund_models.dart';

final String COLLECTION_EXTRA='extra';
class UserService{
  static final Firestore db=Firestore.instance;

//  static Future addRefund(RefundModels refundModels)async{
//    final doc=db.collection(COLLECTION_EXTRA).document('RefundPolicy').collection('RefundPolicy').document(refundModels.refundKey);
//    return await doc.setData(refundModels.toMap());
//  }
  static Future<RefundModels> getRefundModels()async{
    final docSnapshot=await db.collection(COLLECTION_EXTRA).document('RefundPolicy').collection('RefundPolicy').document('refundKey').get();

    return RefundModels.formMap(docSnapshot.data);
  }

  static Future addContactUs(ContactUsModels contactUsModels,String date)async{
    final doc=db.collection(COLLECTION_EXTRA).document('contactUs').collection(date).document(contactUsModels.keyName);
    return await doc.setData(contactUsModels.tomap());
  }
  static Future<List<ContactUsModels>> getAllContactUsModelsinfo(String date)async{
    QuerySnapshot snapshot=await db.collection(COLLECTION_EXTRA).document('contactUs').collection(date).getDocuments();
    if(snapshot!=null){
      return snapshot.documents.map((e) =>ContactUsModels.formMap(e.data)).toList();
    }
  }


}