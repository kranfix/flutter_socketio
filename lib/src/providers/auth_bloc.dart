part of 'providers.dart';

enum AuthStatus { idle, loggedIn, loggedOut }

class AuthBloc extends ChangeNotifier {
  static User user;
  static String get username => '${user.firstName}_${user.lastName}';

  AuthBloc({this.persistance}) : assert(persistance != null);

  final AuthPersistance persistance;

  AuthStatus _status = AuthStatus.idle;
  AuthStatus get status => _status;

  AccountData _savedAccount;
  AccountData get savedAccount => _savedAccount;

  AppClient get client => AppClient.getInstance();

  Future<void> login({
    String email,
    String password,
    bool shouldRememberAccount = true,
    void Function() onLoginError,
  }) async {
    assert(email != null);
    assert(password != null);

    await Services.auth.login(email: email, password: password);
    if (client.token == null) {
      if (onLoginError != null) {
        onLoginError();
      }
      return;
    }

    await fetchMe();
    if (shouldRememberAccount ?? false) {
      await persistance.saveAccount(email, password);
    } else {
      await persistance.cleanAccount();
    }
    notifyListeners();
  }

  Future<void> logout() async {
    client.clearToken();
    await persistance.clearToken();
    _status = AuthStatus.loggedOut;
    notifyListeners();
  }

  Future<void> validateToken() async {
    final token = await persistance.readToken();
    if (token == null) {
      _status = AuthStatus.loggedOut;
      _savedAccount = await persistance.readSavedAccount();
      return;
    }
    await fetchMe(token: token);
    _savedAccount = await persistance.readSavedAccount();
  }

  Future<void> fetchMe({String token}) async {
    // TODO: use a true id.
    user = await Services.user.fetchOne(id: 1);
    if (client.token != null) {
      await persistance.saveToken(client.token);
    }
    if (user == null) {
      _status = AuthStatus.loggedOut;
    } else {
      _status = AuthStatus.loggedIn;
    }
  }
}

abstract class AuthPersistance {
  Future<void> clearToken();
  Future<String> readToken();
  Future<void> saveToken(String token);
  Future<void> cleanAccount();
  Future<AccountData> readSavedAccount();
  Future<void> saveAccount(String username, String password);
}

class AccountData {
  const AccountData({this.email, this.password})
      : assert(email != null),
        assert(password != null);

  final String email;
  final String password;
}

class AuthHivePersistance implements AuthPersistance {
  static Future<Box<String>> openBox() => Hive.openBox<String>('auth');

  static Box<String> get box => Hive.box<String>('auth');

  @override
  Future<void> cleanAccount() async {
    box.delete('username');
    box.delete('password');
  }

  @override
  Future<void> clearToken() async => box.delete('token');

  @override
  Future<String> readToken() async => box.get('token');

  @override
  Future<void> saveToken(String token) async => box.put('token', token);

  @override
  Future<AccountData> readSavedAccount() async {
    final username = box.get('username');
    final password = box.get('password');
    if (username == null || password == null) return null;
    return AccountData(email: username, password: password);
  }

  @override
  Future<void> saveAccount(String username, String password) async =>
      box.putAll({"username": username, "password": password});
}
