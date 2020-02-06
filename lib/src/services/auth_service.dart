part of 'services.dart';

class AuthService {
  AppClient get client => AppClient.getInstance();

  Future<String> login(
      {String email, String password, bool overrideToken = true}) async {
    final data = await client.$post<Map<String, dynamic>>(
      "/api/login",
      headers: {"content-type": ContentType.json.toString()},
      body: {"email": email, "password": password},
    );
    if (data == null) return null;
    final token = data["token"] as String;
    if (overrideToken) {
      client.token = token;
    }
    return token;
  }

  Future<UserListData> fetchUsers({int page = 1}) async {
    final data = await client.$get<Map<String, dynamic>>(
      "/api/users?page=$page",
      headers: {"content-type": ContentType.json.toString()},
    );
    return UserListData.fromMap(data);
  }
}

class UserListData {
  final Map<String, dynamic> _data;

  const UserListData._(this._data);

  factory UserListData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return UserListData._(map);
  }

  int get page => _data['page'];
  int get perPage => _data['per_page'];
  int get total => _data['total'];
  List<User> get users => User.parseList(_data['data']);
}
