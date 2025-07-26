import 'package:workmanager/workmanager.dart';

import 'notification_manager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await NotificationManager.initializeNotifications();
    await NotificationManager.showNotification();
    return Future.value(true);
  });
}
