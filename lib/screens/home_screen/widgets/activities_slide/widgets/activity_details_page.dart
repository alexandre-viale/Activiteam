import 'package:flutter/material.dart';
import 'package:tp2_dev_mobile/managers/activities_manager.dart';
import 'package:tp2_dev_mobile/model/activity.dart';
import 'package:tp2_dev_mobile/utils/capitalize.dart';

class ActivityDetailsPage extends StatelessWidget {
  final Activity activity;

  const ActivityDetailsPage({Key? key, required this.activity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          ActivitiesManager.addToCart(activity, context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Activité ${activity.title} ajoutée au panier',
              ),
            ),
          );
          Navigator.of(context).pop();
        },
        label: const Text('Ajouter au panier'),
        icon: const Icon(Icons.shopping_bag),
      ),
      appBar: AppBar(
        title: Text("Activité - ${activity.title}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'activity_image_${activity.title}',
              child: Image.network(activity.imageLink ?? "", fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    activity.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 8),
                      Text(
                        activity.place,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.category),
                      const SizedBox(width: 8),
                      Text(
                        capitalize(activity.category.value),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.people),
                      const SizedBox(width: 8),
                      Text(
                        '${activity.minimumPeople} personnes minimum',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.euro_symbol),
                      const SizedBox(width: 8),
                      Text(
                        '${activity.price}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
