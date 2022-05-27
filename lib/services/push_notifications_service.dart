//SHA1: B2:6D:81:E5:44:A8:DF:A9:3D:11:B3:39:B4:28:3D:69:C8:9F:73:6D
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream =
      new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;
  //tipos de notificaciones
  static Future _backgroundHandler(RemoteMessage message) async {
    //print('onBackground handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'no title');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    //print('onMessage handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'no title');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    // print('onMessageOpenApp handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'no title');
  }

  static Future initializeApp() async {
    //notificaciones push
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_backgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_backgroundHandler);
    //notificaciones locales
  }

  static closeStreams() {
    _messageStream.close();
  }
}
