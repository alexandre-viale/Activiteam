import 'package:tp2_dev_mobile/enums/category.dart';

class Activity {
  String id;
  Category category;
  String title;
  String place;
  int minimumPeople;
  double price;
  String? imageLink;
  Activity({
    required this.id,
    required this.category,
    required this.title,
    required this.place,
    required this.minimumPeople,
    required this.price,
    required this.imageLink,
  });

  factory Activity.fromMap(Map<String, dynamic> map, String documentId) {
    return Activity(
      id: documentId,
      title: map['title'],
      category: Category.fromString(map['category'])!,
      place: map['place'],
      minimumPeople: map['minimumPeople'],
      price: map['price'].toDouble(),
      imageLink: map['imageLink'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category.value,
      'place': place,
      'minimumPeople': minimumPeople,
      'price': price,
      'imageLink': imageLink,
    };
  }
}
