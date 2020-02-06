part of 'models.dart';

class User {
  final Map<String, dynamic> _data;

  User._(this._data);

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return User._(map);
  }

  int get id => _data['id'];
  String get email => _data['email'];
  String get firstName => _data['first_name'];
  String get lastName => _data['last_name'];
  String get avatar => _data['avatar'];

  static List<User> parseList(List<dynamic> userList) =>
      [for (final u in userList) if (u != null) User._(u)];
}
