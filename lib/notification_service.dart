import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:voc/api_service/model/message.dart';

class NotificationService {

  static const String _channelKey = 'message';
  static const String _channelName = 'Message';
  static const String _channelDesc = 'Receive New Message';

  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: _channelKey,
              channelName: _channelName,
              channelDescription: _channelDesc,
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Private,)
        ],
        debug: false);
    await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  static Future<void> checkNotificationPermission() async {
    if (!await AwesomeNotifications().isNotificationAllowed()) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  static Future<void> createNewNotification(Message message) async {
    Random random = Random();
    int randomNumber = random.nextInt(100);
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: randomNumber, // -1 is replaced by a random number
            channelKey: _channelKey,
            title: message.sender.fullName,
            body:message.translationMsg,
            summary: message.sender.fullName,
            largeIcon: message.sender.photoUrl,
            groupKey: message.chatId,
            notificationLayout: NotificationLayout.Messaging,
            payload: message.toJson() as Map<String, String>));
  }

  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {

    }
  }
}