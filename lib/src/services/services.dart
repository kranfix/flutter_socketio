import 'dart:convert';
import 'dart:io';
import '../models/models.dart';
import 'package:http/http.dart' as http;

part 'client.dart';
part 'auth_service.dart';

class Services {
  static final AuthService auth = AuthService();
}
