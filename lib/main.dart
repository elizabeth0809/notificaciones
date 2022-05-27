import 'package:flutter/material.dart';
import 'package:noticaciones/screens/home_screen.dart';
import 'package:noticaciones/screens/message_screen.dart';
import 'package:noticaciones/services/push_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messegerKey =
      new GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    super.initState();
    //contexto
    PushNotificationService.messagesStream.listen((message) {
      // print('Myapp: $message');
      //con esto al recibir la notificacion se cambia de pantalla
      navigatorKey.currentState?.pushNamed('message', arguments: message);
      final snackBar = SnackBar(content: Text(message));
      messegerKey.currentState?.showSnackBar(snackBar);
      //Navigator.pushNamed(context, 'message); esto es para la navegacion
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material app',
        initialRoute: 'home',
        navigatorKey: navigatorKey, //poder navegar
        scaffoldMessengerKey: messegerKey, //mostrar snacks
        routes: {
          'home': (_) => HomeScreen(),
          'message': (_) => MessageScreen()
        });
  }
}
