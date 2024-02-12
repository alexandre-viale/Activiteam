import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2_dev_mobile/animations/smooth_transition_text.dart';
import 'package:tp2_dev_mobile/managers/activities_manager.dart';
import 'package:tp2_dev_mobile/providers/activiteam_user_notifier.dart';
import 'package:tp2_dev_mobile/providers/activities_notifier.dart';
import 'package:tp2_dev_mobile/providers/cart_notifier.dart';
import 'package:tp2_dev_mobile/repositories/user_repository.dart';
import 'package:tp2_dev_mobile/screens/home_screen/widgets/activities_slide/activities_slide.dart';
import 'package:tp2_dev_mobile/screens/home_screen/widgets/cart_slide/cart_slide.dart';
import 'package:tp2_dev_mobile/screens/home_screen/widgets/activiteam_drawer.dart';
import 'package:tp2_dev_mobile/screens/home_screen/widgets/profile_slide/profile_slide.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  String pageTitle = 'Activités';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // On récupère les activités, le panier et les données supplémentaires de l'utilisateur au chargement de l'application
    // car c'est une application avec scroll horizontal, et on ne veut pas avoir de stuttering lors du changement de page.
    // On les stocke dans des notifiers pour les réutiliser dans les différents widgets et avoir une seule source de vérité
    final activitiesNotifier =
        Provider.of<ActivitiesNotifier>(context, listen: false);
    final cartNotifier = Provider.of<CartNotifier>(context, listen: false);
    ActivitiesManager.fetchActivities(activitiesNotifier);
    cartNotifier.fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    List<GlobalKey<NavigatorState>> pageKeys = [
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
    ];
    return Scaffold(
      drawer: const ActiviteamDrawer(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: SmoothTransitionText(
          icon: _currentIndex == 0
              ? Icons.article
              : _currentIndex == 1
                  ? Icons.shopping_bag
                  : Icons.person,
          text: pageTitle,
          style: Theme.of(context).appBarTheme.titleTextStyle!,
        ),
        actions: const [],
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            PageView(
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  switch (index) {
                    case 0:
                      pageTitle = 'Activités';
                      break;
                    case 1:
                      pageTitle = 'Panier';
                      break;
                    case 2:
                      pageTitle = 'Profil';
                      break;
                  }
                  _currentIndex = index;
                });
              },
              children: <Widget>[
                Container(
                  key: pageKeys[0],
                  color: Colors.transparent,
                  child: const ActivitiesSlide(),
                ),
                Container(
                  key: pageKeys[1],
                  color: Colors.transparent,
                  child: const CartSlide(),
                ),
                Container(
                  key: pageKeys[2],
                  color: Colors.transparent,
                  child: const ProfileSlide(),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 15,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: _currentIndex == 0
                ? const Icon(Icons.article)
                : const Icon(Icons.article_outlined),
            title: const Text('Activités'),
            activeColor: Theme.of(context).primaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: _currentIndex == 1
                ? const Icon(Icons.shopping_bag)
                : const Icon(Icons.shopping_bag_outlined),
            title: const Text('Panier'),
            activeColor: Theme.of(context).primaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: _currentIndex == 2
                ? const Icon(Icons.person)
                : const Icon(Icons.person_outlined),
            title: const Text('Profil'),
            activeColor: Theme.of(context).primaryColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
