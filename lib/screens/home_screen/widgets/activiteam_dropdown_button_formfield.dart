import 'package:flutter/material.dart';

class ActiviteamDropdownButtonFormField<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> _items;
  final String? Function(T?)? _validator;
  final String? _hint;
  final T? _currentValue;
  final Function(T?)? _onChanged;
  final Icon? _prefixIcon;
  const ActiviteamDropdownButtonFormField({
    required List<DropdownMenuItem<T>> items,
    required String? Function(T?)? validator,
    String? hint,
    required T? currentValue,
    required Function(T?)? onChanged,
    Icon? prefixIcon,
    Key? key,
  })  : _validator = validator,
        _items = items,
        _hint = hint,
        _currentValue = currentValue,
        _onChanged = onChanged,
        _prefixIcon = prefixIcon,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        disabledColor: Colors.black,
      ),
      child: DropdownButtonFormField<T>(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15),
        ),
        onChanged: _onChanged,
        itemHeight: 50,
        icon: const Icon(Icons.arrow_drop_down),
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        hint: _hint != null ? Text(_hint!) : null,
        decoration: InputDecoration(
          prefixIconColor: Theme.of(context).primaryColor,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          prefixIcon: _prefixIcon,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
        ),
        value: _currentValue,
        items: _items,
        validator: _validator,
        isExpanded: true,
      ),
    );
  }
}
