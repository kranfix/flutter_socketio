part of 'services.dart';

class AppClient {
  static final _instances = <String, AppClient>{};

  AppClient._({this.server, this.token, this.onExpiredToken})
      : assert(server != null);

  factory AppClient({
    String server,
    String token,
    void Function() onExpiredToken,
    String tag: "default",
  }) {
    assert(tag != null);
    final client = AppClient._(
      server: server,
      token: token,
      onExpiredToken: onExpiredToken,
    );
    _instances[tag] = client;
    return client;
  }

  final String server;
  final void Function() onExpiredToken;

  String token;

  Future<T> $get<T>(
    String uri, {
    Map<String, String> headers,
  }) async {
    final url = server + uri;
    Map<String, String> _headers = {
      if (token != null) "Authorization": "Bearer $token",
      if (headers != null) ...headers,
    };
    try {
      final res = await http.get(url, headers: _headers);
      return _processResponse<T>(res);
    } catch (e) {
      return null;
    }
  }

  Future<T> $post<T>(
    String uri, {
    Map<String, String> headers,
    Encoding encoding,
    Map<String, dynamic> body,
  }) async {
    final url = server + uri;
    Map<String, String> _headers = {
      if (token != null) "Authorization": "Bearer $token",
      if (headers != null) ...headers,
    };
    try {
      final res = await http.post(url,
          headers: _headers, encoding: encoding, body: json.encode(body));
      return _processResponse<T>(res);
    } catch (e) {
      return null;
    }
  }

  T _processResponse<T>(http.Response response) {
    if (response.statusCode < 400) {
      return json.decode(utf8.decode(response.body.codeUnits));
    }

    if (onExpiredToken != null) {
      onExpiredToken();
    }
    return null;
  }

  void clearToken() => token = null;

  static AppClient getInstance({String tag: "default"}) {
    assert(tag != null);
    assert(_instances.containsKey(tag));
    return _instances[tag];
  }
}
