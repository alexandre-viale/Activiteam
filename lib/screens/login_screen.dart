import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp2_dev_mobile/screens/home_screen/widgets/activiteam_form_field.dart';
import 'package:tp2_dev_mobile/utils/regexp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _hasTriedToSubmit = false;
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ActiviTeam'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 300,
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              autovalidateMode: _hasTriedToSubmit
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ActiviteamFormField(
                      controller: _emailController,
                      labelText: 'Email',
                      hintText: 'Entrez votre email',
                      prefixIcon: Icons.email,
                      validator: validateEmail,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ActiviteamFormField(
                      controller: _passwordController,
                      labelText: 'Mot de passe',
                      hintText: 'Entrez votre mot de passe',
                      prefixIcon: Icons.lock,
                      suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          }),
                      validator: validatePassword,
                      obscureText: !_isPasswordVisible,
                    ),
                  ),
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
                    onPressed: _isLoading ? null : handleSignIn,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Se connecter'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      disabledBackgroundColor: Colors.grey[200],
                      disabledForegroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      minimumSize:
                          Size(MediaQuery.of(context).size.width - 32, 50),
                    ),
                    onPressed: _isLoading
                        ? null
                        : () {
                            Navigator.pushReplacementNamed(
                                context, '/register');
                          },
                    child: Text(
                      'Pas encore de compte ?',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleSignIn() async {
    setState(() {
      _hasTriedToSubmit = true;
    });
    if (_formKey.currentState!.validate()) {
      bool result = await signInWithEmailAndPassword();
      if (!mounted) {
        return;
      }
      if (result) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  Future<bool> signInWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loginFirebaseErrorCodes[e.code]!),
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

  String? validateEmail(value) {
    if (value!.isEmpty) {
      return 'Veuillez entrer votre email';
    }
    if (!isEmail(value)) {
      return 'Veuillez entrer un email valide';
    }
    return null;
  }

  Map<String, String> loginFirebaseErrorCodes = {
    'INVALID_LOGIN_CREDENTIALS': 'Email ou mot de passe invalide',
    'invalid-credential': 'Email ou mot de passe invalide',
  };
}
