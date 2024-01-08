import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp2_dev_mobile/screens/home_screen/widgets/activiteam_form_field.dart';
import 'package:tp2_dev_mobile/utils/regexp.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _hasAttemptedSignUp = false;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un compte'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            autovalidateMode: _hasAttemptedSignUp
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ActiviteamFormField(
                    controller: _emailController,
                    hintText: 'Entrez votre email',
                    labelText: 'Email',
                    prefixIcon: Icons.email,
                    validator: validateEmail,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ActiviteamFormField(
                      controller: _passwordController,
                      hintText: 'Entrez votre mot de passe',
                      labelText: 'Mot de passe',
                      prefixIcon: Icons.lock,
                      validator: validatePassword,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).primaryColor,
                        ),
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ActiviteamFormField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirmez le mot de passe',
                      labelText: 'Confirmation du mot de passe',
                      prefixIcon: Icons.lock,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).primaryColor,
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                      validator: validateConfirmPassword,
                      obscureText: _obscureConfirmPassword,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                    )),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    minimumSize:
                        Size(MediaQuery.of(context).size.width - 32, 50),
                  ),
                  onPressed: _isLoading ? null : validateForm,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Créer un compte'),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize:
                        Size(MediaQuery.of(context).size.width - 32, 50),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    'Vous avez déjà un compte ?',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> registerWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message!),
            backgroundColor: Colors.red,
          ),
        );
      }
      return false;
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void validateForm() async {
    trimTextFields();
    setState(() {
      _hasAttemptedSignUp = true;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    bool result = await registerWithEmailAndPassword();
    if (mounted && result) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {}
  }

  void trimTextFields() {
    _emailController.text = _emailController.text.trim();
    _passwordController.text = _passwordController.text.trim();
    _confirmPasswordController.text = _confirmPasswordController.text.trim();
  }

  String? validateEmail(value) {
    if (value!.isEmpty) {
      return 'Veuillez entrer votre email';
    }
    if (!isEmail(value)) {
      return 'Veuillez entrer un email valide';
    }
    return null;
  }

  String? validateConfirmPassword(value) {
    if (value!.isEmpty) {
      return 'Veuillez confirmer votre mot de passe';
    }
    if (value != _passwordController.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }
}
