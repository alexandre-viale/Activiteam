import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp2_dev_mobile/model/activiteam_user.dart';

class UserRepository {
  static Future<bool> createUser(ActiviTeamUser user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    try {
      await users.doc(user.id).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<ActiviTeamUser> getUser(String id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    DocumentSnapshot user = await users.doc(id).get();
    return ActiviTeamUser.fromMap(user.data() as Map<String, dynamic>, user.id);
  }

  static Future<ActiviTeamUser> updateUser(ActiviTeamUser user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    await users.doc(user.id).update(user.toMap());
    return user;
  }
}
