import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class PushHomePage extends StatefulWidget {
  const PushHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _PushHomePageState();
}

class _PushHomePageState extends State<PushHomePage> {
  String? _token;
  String _lastMessage = 'Sin mensajes aún';

  @override
  void initState() {
    super.initState();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    // 1) Solicitar permisos
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print(' Permisos: ${settings.authorizationStatus}');

    // 2) Permisos adicionales iOS/macOS
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    // 3) Obtener token FCM
    String? token = await FirebaseMessaging.instance.getToken();
    print(' Token FCM: $token');

    setState(() {
      _token = token;
    });

    // 4) Mensajes en foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('[FG] Mensaje en foreground: ${message.data}');

      String title = message.notification?.title ?? 'Sin título';
      String body = message.notification?.body ?? 'Sin cuerpo';

      setState(() {
        _lastMessage = 'Foreground -> $title: $body';
      });

      _showLocalNotification(title, body);
    });

    // 5) Usuario toca la notificación
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(' Notificación abierta por el usuario');

      String title = message.notification?.title ?? 'Sin título';
      String body = message.notification?.body ?? 'Sin cuerpo';

      setState(() {
        _lastMessage = 'Abierta desde notificación -> $title: $body';
      });
    });

    // 6) Mensaje que abrió la app desde terminada
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      String title = initialMessage.notification?.title ?? 'Sin título';
      String body = initialMessage.notification?.body ?? 'Sin cuerpo';

      setState(() {
        _lastMessage = 'Cold start -> $title: $body';
      });
    }
  }

  Future<void> _showLocalNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'demo_channel_id',
      'Demo Channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
      macOS: darwinDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Push Notifications (iOS + Android)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Token FCM (copia esto para enviar desde el servidor):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SelectableText(
              _token ?? 'Obteniendo token...',
              style: const TextStyle(fontSize: 12),
            ),
            const Divider(height: 32),
            const Text(
              'Último mensaje recibido:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(_lastMessage),
          ],
        ),
      ),
    );
  }
}
