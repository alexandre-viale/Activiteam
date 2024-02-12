import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2_dev_mobile/managers/activities_manager.dart';
import 'package:tp2_dev_mobile/model/cart_item.dart';
import 'package:tp2_dev_mobile/providers/activities_notifier.dart';
import 'package:tp2_dev_mobile/providers/cart_notifier.dart';
import 'package:tp2_dev_mobile/model/activity.dart';
import 'package:tp2_dev_mobile/theme/theme.dart';

class CartSlide extends StatefulWidget {
  const CartSlide({super.key});

  @override
  State<CartSlide> createState() => _CartSlideState();
}

class _CartSlideState extends State<CartSlide> {
  @override
  Widget build(BuildContext context) {
    ActivitiesNotifier activitiesNotifier =
        Provider.of<ActivitiesNotifier>(context);
    CartNotifier cartProvider = Provider.of<CartNotifier>(context);
    List<CartItem> cartItems = cartProvider.items;
    double total = cartItems.fold(
        0,
        (previousValue, element) =>
            previousValue +
            element.quantity *
                activitiesNotifier.getActivityById(element.id).price);
    if (cartItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const Text(
              'Votre panier est vide',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ajoutez des activités pour commencer',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
    return Stack(
      children: [
        ListView.separated(
          padding: const EdgeInsets.only(bottom: 60),
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            CartItem cartItem = cartItems[index];
            Activity activity = activitiesNotifier.getActivityById(cartItem.id);

            return Card(
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    activity.imageLink!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  activity.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 4.0),
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              activity.place,
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.euro_symbol, size: 16),
                        const SizedBox(width: 4.0),
                        Text(
                          activity.price.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.remove,
                        size: 24,
                      ),
                      onPressed: () {
                        ActivitiesManager.removeOneFromCart(activity, context);
                      },
                    ),
                    Text('x${cartItem.quantity}'),
                    IconButton(
                      icon: const Icon(
                        Icons.add,
                        size: 24,
                      ),
                      onPressed: () {
                        ActivitiesManager.addToCart(activity, context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
        if (total != 0)
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Total:  $total €",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        Positioned(
          bottom: 10,
          right: 16,
          child: FloatingActionButton.extended(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Fonctionnalité non implémentée, ce bouton n\'est présent que pour des raisons esthétiques',
                  ),
                ),
              );
            },
            label: const Text('Valider le panier'),
            icon: const Icon(Icons.shopping_cart),
          ),
        ),
      ],
    );
  }
}
