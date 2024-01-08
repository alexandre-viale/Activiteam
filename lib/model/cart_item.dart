import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String id;
  final DocumentReference ref;
  int quantity;

  CartItem({
    required this.id,
    required this.ref,
    required this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> map, String documentId) {
    return CartItem(
      id: documentId,
      ref: map['ref'],
      quantity: map['quantity'],
    );
  }
}
