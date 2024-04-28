import 'package:e_book/Components/BackButton.dart';
import 'package:e_book/Components/BookTile.dart';
import 'package:e_book/Components/PrimaryButton.dart';
import 'package:e_book/Config/Colors.dart';
import 'package:e_book/Config/ConstValue.dart';
import 'package:e_book/Controller/AuthController.dart';
import 'package:e_book/Controller/BookController.dart';
import 'package:e_book/Models/BookModel.dart';
import 'package:e_book/Models/Data.dart';
import 'package:e_book/Pages/AddNewBook/AddNewBook.dart';
import 'package:e_book/Pages/UpdateBook/UpdateBook.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Homepage/HomePage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    BookController bookController = Get.put(BookController());

    return Scaffold(
      floatingActionButton: authController.auth.currentUser!.email == adminEmail
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.background,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authController.signout();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.background,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            color: Theme.of(context).colorScheme.primary,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
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
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                  ],
                ),
              )
            ]),
          ),
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
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<BookModel>>(
              stream: bookController.getBookAsync(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CupertinoActivityIndicator();
                } else if (snapshot.hasData) {
                  List<BookModel> bookList = snapshot.data!;
                  return Column(
                      children: bookList
                          .map(
                            (e) => Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 110,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(e.coverUrl!),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: 150, child: Text(e.title!)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Get.to(UpdateBook(book: e));
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                            title: "Delete Book",
                                            confirm: OutlinedButton.icon(
                                                onPressed: () {
                                                  ElevatedButton.icon(
                                                      onPressed: () {
                                                        bookController
                                                            .deleteBook(
                                                          e.id!,
                                                          e.category!,
                                                        );
                                                      },
                                                      icon: Icon(Icons.delete),
                                                      label: Text("Delete"));
                                                },
                                                icon: Icon(Icons.delete),
                                                label: Text("Delete")),
                                            cancel: ElevatedButton.icon(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: Icon(Icons.close),
                                                label: Text("Cancle")),
                                            content: Column(
                                              children: [
                                                Text(
                                                    "Did you realy want to delete book")
                                              ],
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.delete),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return Text("No data");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
