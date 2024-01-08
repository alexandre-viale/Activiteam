enum Category {
  sport('sport'),
  culture('culture'),
  art('art'),
  music('music');

  final String value;
  const Category(this.value);

  static Category? fromString(String? value) {
    if (value == null) {
      return null;
    }
    return Category.values
        .firstWhere((element) => element.toString() == 'Category.$value');
  }
}
