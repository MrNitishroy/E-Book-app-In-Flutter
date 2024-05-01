import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/Config/Messages.dart';
import 'package:e_book/Models/NotificationModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class NotificationController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  final uuid = Uuid();

  Future<void> addNotification(
      String title, String des, String startTime, String endTime) async {
    isLoading.value = true;
    var id = uuid.v1();

    try {
      var newNotifi = NotificationModel(
        id: id,
        title: title,
        des: des,
        startingTime: startTime,
        endingTime: endTime,
      );
      await db.collection("notification").doc(id).set(
            newNotifi.toJson(),
          );
      successMessage("Done");
    } catch (ex) {
      errorMessage(ex.toString());
    }
    isLoading.value = false;
  }

  Stream<List<NotificationModel>> getNotification() {
    return db.collection("notification").snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => NotificationModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Future<void> deleteNotification(String id) async {
    await db.collection("notification").doc(id).delete();
  }
}
