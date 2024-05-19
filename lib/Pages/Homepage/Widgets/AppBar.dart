import 'package:e_book/Config/Colors.dart';
import 'package:e_book/Controller/AuthController.dart';
import 'package:e_book/Pages/NotificationPage/NotificationPage.dart';
import 'package:e_book/Pages/ProfilePage/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../ProfilePage/ProfilePage2.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Get.to(ProfilePage());
          },
          child: CircleAvatar(
              radius: 25,
              backgroundColor: Theme.of(context).colorScheme.background,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                      authController.auth.currentUser!.photoURL!))),
        ),
        Text(
          "StudySphare",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.background,
              ),
        ),
        IconButton(
          onPressed: () {
            Get.to(const NotificationPage());
          },
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
