import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2_dev_mobile/model/activiteam_user.dart';
import 'package:tp2_dev_mobile/providers/activiteam_user_notifier.dart';
import 'package:tp2_dev_mobile/repositories/user_repository.dart';
import 'package:tp2_dev_mobile/screens/home_screen/widgets/activiteam_form_field.dart';
import 'package:tp2_dev_mobile/screens/home_screen/widgets/profile_slide/widgets/add_activity_screen.dart';

class ProfileSlide extends StatefulWidget {
  const ProfileSlide({super.key});

  @override
  State<ProfileSlide> createState() => _ProfileSlideState();
}

class _ProfileSlideState extends State<ProfileSlide> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _hasTriedToSubmit = false;
  @override
  void initState() {
    updateView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 96),
          child: Form(
            key: _formKey,
            autovalidateMode: _hasTriedToSubmit
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                Text(
                  'Modification du profil',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Vous pouvez modifier les informations relatives à votre profil ici.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ActiviteamFormField(
                  readOnly: true,
                  labelText: 'Login (email)',
                  prefixIcon: Icons.person,
                  controller: _loginController,
                  hintText: '',
                  validator: null,
                ),
                const SizedBox(height: 16),
                ActiviteamFormField(
                  labelText: 'Mot de passe',
                  prefixIcon: Icons.lock,
                  controller: _passwordController,
                  hintText: '',
                  obscureText: true,
                  validator: null,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 16),
                ActiviteamFormField(
                  labelText: 'Anniversaire',
                  prefixIcon: Icons.cake,
                  controller: _birthdayController,
                  hintText: '',
                  validator: null,
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 16),
                ActiviteamFormField(
                  labelText: 'Adresse',
                  prefixIcon: Icons.location_on_rounded,
                  controller: _addressController,
                  hintText: '',
                  validator: null,
                  keyboardType: TextInputType.streetAddress,
                ),
                const SizedBox(height: 16),
                ActiviteamFormField(
                  labelText: 'Code postal',
                  prefixIcon: Icons.numbers_outlined,
                  controller: _zipCodeController,
                  hintText: '',
                  validator: null,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                ActiviteamFormField(
                  labelText: 'Ville',
                  prefixIcon: Icons.location_city,
                  controller: _cityController,
                  hintText: '',
                  validator: null,
                  keyboardType: TextInputType.streetAddress,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: updateUser,
                  child: const Text('Enregistrer'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddActivityScreen()),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.article),
        label: const Text('Ajouter une activité'),
      ),
    );
  }

  void updateUser() {
    _hasTriedToSubmit = true;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final userNotifier =
          Provider.of<ActiviteamUserNotifier>(context, listen: false);
      final userId = userNotifier.user?.id;
      UserRepository.updateUser(ActiviTeamUser(
        id: userId!,
        login: _loginController.text,
        password: _passwordController.text,
        birthday: _birthdayController.text,
        address: _addressController.text,
        zipCode: _zipCodeController.text,
        city: _cityController.text,
      )).then((value) {
        userNotifier.setUser(value);
        updateView();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profil mis à jour avec succès'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      });
    }
  }

  void updateView() {
    final userNotifier =
        Provider.of<ActiviteamUserNotifier>(context, listen: false);
    User user = FirebaseAuth.instance.currentUser!;
    UserRepository.getUser(user.uid).then((user) {
      userNotifier.setUser(user);
    });
    _loginController.text = userNotifier.user?.login ?? '';
    _birthdayController.text = userNotifier.user?.birthday ?? '';
    _addressController.text = userNotifier.user?.address ?? '';
    _zipCodeController.text = userNotifier.user?.zipCode ?? '';
    _cityController.text = userNotifier.user?.city ?? '';
  }
}
