import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobtox/core/tox_service.dart';
import 'package:mobtox/core/tox_ffi.dart';
import 'package:mobtox/core/database.dart';
import 'package:mobtox/ui/screens/home_screen.dart';

void main() async {
  // Обязательная инициализация Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация базы данных
  await ToxDatabase.instance;

  // Создаем экземпляры сервисов
  final toxFFI = ToxFFI();
  final toxService = ToxService(toxFFI);

  // Инициализация Tox
  await toxService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: toxService),
      ],
      child: const MobtoxApp(),
    ),
  );
}

class MobtoxApp extends StatelessWidget {
  const MobtoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mobtox',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}