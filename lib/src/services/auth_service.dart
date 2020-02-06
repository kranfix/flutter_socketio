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
}
