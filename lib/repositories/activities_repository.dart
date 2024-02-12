import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tp2_dev_mobile/model/activity.dart';

class ActivitiesRepository {
  static Future<List<Activity>> getActivities() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await firestore.collection('activities').get();

    return querySnapshot.docs.map((doc) {
      return Activity.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  static Future<Activity> createActivity(Activity activity) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference activities = firestore.collection('activities');
    DocumentReference docRef = await activities.add(activity.toMap());
    DocumentSnapshot doc = await docRef.get();
    return Activity.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  static Future<void> addToCart(Activity activity) async {
    User user = FirebaseAuth.instance.currentUser!;
    String userId = user.uid;
    CollectionReference cart = FirebaseFirestore.instance.collection('cart');
    DocumentReference userCartRef = cart.doc(userId);

    DocumentReference activityRef =
        FirebaseFirestore.instance.collection('activities').doc(activity.id);

    DocumentSnapshot userCartSnapshot = await userCartRef.get();

    if (userCartSnapshot.exists) {
      Map<String, dynamic> cartData =
          userCartSnapshot.data() as Map<String, dynamic>;
      if (cartData['items'] != null && cartData['items'][activity.id] != null) {
        cartData['items'][activity.id]['quantity'] += 1;
      } else {
        cartData['items'][activity.id] = {'ref': activityRef, 'quantity': 1};
      }
      await userCartRef.update(cartData);
    } else {
      await userCartRef.set({
        'items': {
          activity.id: {
            'ref': activityRef,
            'quantity': 1,
          }
        }
      });
    }
  }

  static Future<void> removeOneFromCart(Activity activity) async {
    User user = FirebaseAuth.instance.currentUser!;
    String userId = user.uid;
    CollectionReference cart = FirebaseFirestore.instance.collection('cart');
    DocumentReference userCartRef = cart.doc(userId);

    DocumentSnapshot userCartSnapshot = await userCartRef.get();

    if (userCartSnapshot.exists) {
      Map<String, dynamic> cartData =
          userCartSnapshot.data() as Map<String, dynamic>;
      if (cartData['items'] != null && cartData['items'][activity.id] != null) {
        if (cartData['items'][activity.id]['quantity'] > 1) {
          cartData['items'][activity.id]['quantity'] -= 1;
        } else {
          cartData['items'].remove(activity.id);
        }
      }
      await userCartRef.update(cartData);
    }
  }
}
