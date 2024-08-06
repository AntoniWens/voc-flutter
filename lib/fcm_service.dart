import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:voc/api_service/model/message.dart';

import 'notification_service.dart';

class FcmService {

  static void onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    final data = Message.fromJson(message.data);
    NotificationService.createNewNotification(data);
  }

  static Stream<RemoteMessage> onMessage() {
    return FirebaseMessaging.onMessage;
  }
}