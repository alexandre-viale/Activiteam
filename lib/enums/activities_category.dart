enum ActivitiesCategory {
  sport('sport'),
  culture('culture'),
  art('art'),
  music('music');

  final String value;
  const ActivitiesCategory(this.value);

  static ActivitiesCategory? fromString(String? value) {
    if (value == null) {
      return null;
    }
    switch (value) {
      case 'sport':
        return ActivitiesCategory.sport;
      case 'culture':
        return ActivitiesCategory.culture;
      case 'art':
        return ActivitiesCategory.art;
      case 'music':
        return ActivitiesCategory.music;
      default:
        return null;
    }
  }
}
