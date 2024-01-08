import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp2_dev_mobile/model/cart_item.dart';

class CartNotifier with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(String activityId) {
    if (_items.any((element) => element.id == activityId)) {
      _items.firstWhere((element) => element.id == activityId).quantity += 1;
    } else {
      CartItem item = CartItem(
        id: activityId,
        quantity: 1,
        ref:
            FirebaseFirestore.instance.collection('activities').doc(activityId),
      );
      _items.add(item);
    }

    notifyListeners();
  }

  void removeItem(String itemId) {
    if (_items.firstWhere((element) => element.id == itemId).quantity > 1) {
      _items.firstWhere((element) => element.id == itemId).quantity -= 1;
    } else {
      _items.removeWhere((element) => element.id == itemId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  Future<void> fetchCartItems() async {
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance
        .collection('cart')
        .doc(user.uid)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;
        Map<String, dynamic> cartItems = data['items'];
        _items.clear();
        cartItems.forEach((key, value) {
          _items.add(CartItem.fromMap(value, key));
        });

        notifyListeners();
      }
    });
  }
}
