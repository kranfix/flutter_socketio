part of 'models.dart';

class Message {
  static const secretTag = "user";

  final Map<String, dynamic> _data;

  const Message._(this._data);

  factory Message.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Message._(map);
  }

  User get user {
    final Map<String, dynamic> _user = _data[secretTag] ?? {};
    return User.fromMap({
      'id': _user['id'] ?? 0,
      'email': _user['email'],
      'first_name': _user['first_name'] ?? 'Unknown',
      'last_name': _user['last_name'] ?? _data['username'],
      'avatar': _user['avatar'] ??
          'https://cdn2.iconfinder.com/data/icons/people-flat-design/64/Man-Person-People-Avatar-User-Happy-512.png',
    });
  }

  String get username => _data["username"];
  String get text => _data['message'];
}
