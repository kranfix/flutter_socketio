import 'env.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/providers/providers.dart';
import 'src/services/services.dart';
import 'src/ui/screens/splash/splash_screen.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Center(
        child: Text('Ups! Algo no esta bien'),
      ),
    );
  };
  AppClient(server: env.server);
  await Hive.initFlutter();
  await AuthHivePersistance.openBox();
  runApp(SocketioApp());
}

class SocketioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthBloc>(
      create: (_) => AuthBloc(
        persistance: AuthHivePersistance(),
      ),
      child: MaterialApp(
        title: 'Intragentes',
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(
              display1: TextStyle(color: Colors.white),
            ),
          ),
          iconTheme: IconThemeData(size: 20),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
