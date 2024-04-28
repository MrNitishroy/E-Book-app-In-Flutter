import 'package:e_book/Config/ConstValue.dart';
import 'package:e_book/Controller/AuthController.dart';
import 'package:e_book/Controller/NotificationController.dart';
import 'package:e_book/Models/NotificationModel.dart';
import 'package:e_book/Pages/AddNotification/AddNotification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    NotificationController notificationController =
        Get.put(NotificationController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          adminEmail == authController.auth.currentUser!.email
              ? IconButton(
                  onPressed: () {
                    Get.to(AddNotificationPage());
                  },
                  icon: Icon(
                    Icons.notification_add,
                    color: Theme.of(context).colorScheme.background,
                  ),
                )
              : SizedBox(),
        ],
      ),
      body: StreamBuilder(
        stream: notificationController.getNotification(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CupertinoActivityIndicator();
          } else if (snapshot.hasData) {
            List<NotificationModel> notifications = snapshot.data!;
            return ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.notifications),
                      tileColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      title: Text("New"),
                      subtitle: Text(
                        notifications[index].des!,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  );
                });
          } else {
            return Text('no Data');
          }
        },
      ),
    );
  }
}
