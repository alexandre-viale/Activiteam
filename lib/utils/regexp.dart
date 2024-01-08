bool isEmail(String email) {
  final RegExp regex =
      RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  return regex.hasMatch(email);
}

String? validatePassword(value) {
  if (value!.isEmpty) {
    return 'Veuillez entrer votre mot de passe';
  }
  if (value.length < 8) {
    return 'Le mot de passe doit contenir au moins 8 caractères';
  }
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Le mot de passe doit contenir au moins une majuscule';
  }
  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Le mot de passe doit contenir au moins un chiffre';
  }
  if (value.contains(RegExp(r'\s'))) {
    return 'Le mot de passe ne contient pas d\'espace';
  }
  return null;
}
