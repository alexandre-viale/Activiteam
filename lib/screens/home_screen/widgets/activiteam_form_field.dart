import 'package:flutter/material.dart';

class ActiviteamFormField extends StatelessWidget {
  final TextEditingController _controller;
  final String _labelText;
  final String _hintText;
  final IconData _prefixIcon;
  final Widget? _suffix;
  final Widget? _suffixIcon;
  final TextInputAction? _textInputAction;
  final TextInputType? _keyboardType;
  final bool _obscureText;
  final TextCapitalization _textCapitalization;
  final String? Function(String?)? _validator;
  final Function(String?)? _onchanged;
  final bool _readOnly;

  const ActiviteamFormField({
    Key? key,
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
    Widget? suffix,
    Widget? suffixIcon,
    required String? Function(String?)? validator,
    TextInputAction? textInputAction = TextInputAction.next,
    TextInputType? keyboardType = TextInputType.text,
    bool obscureText = false,
    Function(String?)? onChanged,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool readOnly = false,
  })  : _controller = controller,
        _labelText = labelText,
        _hintText = hintText,
        _prefixIcon = prefixIcon,
        _suffix = suffix,
        _suffixIcon = suffixIcon,
        _validator = validator,
        _textInputAction = textInputAction,
        _keyboardType = keyboardType,
        _obscureText = obscureText,
        _textCapitalization = textCapitalization,
        _onchanged = onChanged,
        _readOnly = readOnly,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: _readOnly,
      validator: _validator,
      controller: _controller,
      textInputAction: _textInputAction,
      keyboardType: _keyboardType,
      obscureText: _obscureText,
      textCapitalization: _textCapitalization,
      onChanged: _onchanged,
      decoration: InputDecoration(
        prefixStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        prefixIcon: Icon(
          _prefixIcon,
          color: Theme.of(context).primaryColor,
        ),
        suffixIcon: _suffixIcon,
        suffix: _suffix,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        labelText: _labelText,
        hintText: _hintText,
      ),
    );
  }
}
