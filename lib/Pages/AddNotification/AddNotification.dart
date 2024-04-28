import 'package:e_book/Components/MyTextFormField.dart';
import 'package:e_book/Controller/NotificationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNotificationPage extends StatelessWidget {
  const AddNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController des = TextEditingController();
    TextEditingController startTime = TextEditingController();
    TextEditingController endTime = TextEditingController();
    NotificationController notificationController =
        Get.put(NotificationController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Notification',
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            MyTextFormField(
              isNumber: false,
              hintText: "Title",
              icon: Icons.title,
              controller: title,
            ),
            const SizedBox(height: 10),
            MyTextFormField(
              isNumber: false,
              hintText: "Description",
              icon: Icons.description,
              controller: des,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: MyTextFormField(
                    isNumber: false,
                    hintText: "Start Time",
                    icon: Icons.currency_rupee,
                    controller: startTime,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MyTextFormField(
                    isNumber: false,
                    hintText: "End Time",
                    icon: Icons.currency_rupee,
                    controller: endTime,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                notificationController.addNotification(
                  title.text,
                  des.text,
                  startTime.text,
                  endTime.text,
                );
                title.clear();
                des.clear();
                startTime.clear();
                endTime.clear();
              },
              icon: const Icon(Icons.done),
              label: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
