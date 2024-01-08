import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ActiviteamDrawer extends StatelessWidget {
  const ActiviteamDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomRight: Radius.circular(45),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
              ),
            ),
            child: const Text(
              'Activiteam',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Déconnexion'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.popUntil(context, (route) => false);
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
