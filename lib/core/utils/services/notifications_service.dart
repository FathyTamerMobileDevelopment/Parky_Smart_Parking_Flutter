import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Initialize Firebase Messaging and Local Notifications
  static Future<void> initialize() async {
    // ✅ Request permission for notifications (iOS & Android)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // ❌ If user denies permission, stop initialization
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      log("🚫 Notification permission denied.");
      return;
    }

    // ✅ Initialize local notifications (Android & iOS)
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iOSInitSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iOSInitSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log("🔔 Notification clicked: ${response.payload}");
      },
    );

    // ✅ Listen for foreground messages (when the app is open)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("📩 New Message: ${message.notification?.title}");
      _showNotification(message);
    });

    // ✅ Get FCM token for push notifications
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      log("🔑 FCM Token: $token");
    } else {
      log("⚠️ Failed to get FCM token.");
    }
  }

  // show notification
  static Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);
    await _localNotifications.show(
      0, // ID
      message.notification?.title ?? "empty title",
      message.notification?.body ?? "empty body",
      notificationDetails,
    );
  }
}
