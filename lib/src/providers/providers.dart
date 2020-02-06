import '../models/models.dart';
import '../services/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

export 'package:provider/provider.dart';

part 'auth_bloc.dart';

// TODO(kranfix): Remove on Provider 4.1.0
extension ConsumerX on BuildContext {
  T read<T>() => Provider.of<T>(this, listen: false);
  T watch<T>() => Provider.of<T>(this, listen: true);
}
