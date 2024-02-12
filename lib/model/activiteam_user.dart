class ActiviTeamUser {
  final String id;
  final String login;
  final String? password;
  final String? birthday;
  final String? address;
  final String? zipCode;
  final String? city;

  ActiviTeamUser({
    required this.id,
    required this.login,
    this.password,
    this.birthday,
    this.address,
    this.zipCode,
    this.city,
  });

  factory ActiviTeamUser.fromMap(Map<String, dynamic> data, String id) {
    return ActiviTeamUser(
      id: id,
      login: data['login'],
      password: data['password'],
      birthday: data['birthday'],
      address: data['address'],
      zipCode: data['zipCode'],
      city: data['city'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'password': password,
      'birthday': birthday,
      'address': address,
      'zipCode': zipCode,
      'city': city,
    };
  }
}
