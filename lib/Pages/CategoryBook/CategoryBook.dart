import 'package:e_book/Controller/BookController.dart';
import 'package:e_book/Models/BookModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../Components/BookCard.dart';
import '../../Components/BookTile.dart';
import '../BookDetails/BookDetails.dart';

class CategoryBook extends StatelessWidget {
  final String categoryName;
  const CategoryBook({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder(
            stream: bookController.getCategoryBook(categoryName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CupertinoActivityIndicator();
              } else if (snapshot.hasData) {
                List<BookModel> books = snapshot.data!;
                return ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return BookTile(
                        ontap: () {
                          Get.to(BookDetails(book: books[index]));
                        },
                        title: books[index].title!,
                        coverUrl: books[index].coverUrl!,
                        author: books[index].author!,
                        price: books[index].price!,
                        rating: books[index].rating?? "0",
                        totalRating: 12,
                      );
                    });
              } else {
                return Text("No Data");
              }
            }),
      ),
    );
  }
}
