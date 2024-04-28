import 'package:e_book/Components/BackButton.dart';
import 'package:e_book/Components/BookTile.dart';
import 'package:e_book/Controller/AuthController.dart';
import 'package:e_book/Controller/BookController.dart';
import 'package:e_book/Pages/AddNewBook/AddNewBook.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfilePage2 extends StatelessWidget {
  const ProfilePage2({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    BookController bookController = Get.put(BookController());
    RxInt seletedValue = 0.obs;
    return Scaffold(
      floatingActionButton:
          authController.auth.currentUser!.email == "nroy7033@gmail.com"
              ? FloatingActionButton(
                  onPressed: () {
                    Get.to(AddNewBookPage());
                  },
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.background,
                  ),
                )
              : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 500,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              color: Theme.of(context).colorScheme.primary,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyBackButton(),
                          Text(
                            "Profile",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                          ),
                          IconButton(
                              onPressed: () {
                                authController.signout();
                              },
                              icon: Icon(
                                Icons.exit_to_app,
                                color: Theme.of(context).colorScheme.background,
                              ))
                        ],
                      ),
                      SizedBox(height: 60),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).colorScheme.background,
                            )),
                        child: Container(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              "${authController.auth.currentUser!.photoURL}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${authController.auth.currentUser!.displayName}",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.background),
                      ),
                      Text(
                        "${authController.auth.currentUser!.email}",
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Add Book"),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Add Course"),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ]),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => CupertinoSlidingSegmentedControl(
                    padding: EdgeInsets.all(7),
                    groupValue: seletedValue.value,
                    children: {
                      0: Container(
                        padding: EdgeInsets.all(7),
                        child: Text("Books"),
                      ),
                      1: Container(
                        padding: EdgeInsets.all(7),
                        child: Text("Courses"),
                      ),
                      2: Container(
                        padding: EdgeInsets.all(7),
                        child: Text("Category"),
                      ),
                    },
                    onValueChanged: (index) {
                      seletedValue.value = index!;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Your Books",
                          style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                  SizedBox(height: 20),
                  Obx(
                    () => Column(
                      children: bookController.currentUserBooks
                          .map((e) => BookTile(
                                title: e.title!,
                                coverUrl: e.coverUrl!,
                                author: e.author!,
                                price: e.price!,
                                rating: e.rating!,
                                totalRating: 12,
                                ontap: () {},
                              ))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
