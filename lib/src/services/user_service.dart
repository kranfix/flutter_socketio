part of 'services.dart';

class UserService {
  AppClient get client => AppClient.getInstance();

  Future<User> fetchOne({int id}) async {
    final data = await client.$get<Map<String, dynamic>>(
      "/api/users/$id",
      headers: {"content-type": ContentType.json.toString()},
    );
    return User.fromMap(data['data']);
  }

  Future<UserListData> fetchMany({int page = 1}) async {
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
