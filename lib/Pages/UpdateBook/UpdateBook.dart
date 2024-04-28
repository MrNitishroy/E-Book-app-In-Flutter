import 'package:e_book/Components/BackButton.dart';
import 'package:e_book/Components/MutiLineTextFormField.dart';
import 'package:e_book/Components/MyTextFormField.dart';
import 'package:e_book/Config/Colors.dart';
import 'package:e_book/Config/ConstValue.dart';
import 'package:e_book/Controller/BookController.dart';
import 'package:e_book/Controller/PdfController.dart';
import 'package:e_book/Models/BookModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateBook extends StatelessWidget {
  final BookModel book;
  const UpdateBook({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    PdfController pdfController = Get.put(PdfController());
    BookController bookController = Get.put(BookController());
    RxString categoryValue = book.category!.obs;

    TextEditingController title = TextEditingController(text: book.title);
    TextEditingController des = TextEditingController(text: book.description);
    TextEditingController author = TextEditingController(text: book.author);
    TextEditingController aboutAuthor =
        TextEditingController(text: book.aboutAuthor);
    TextEditingController price = TextEditingController(text: "0");
    TextEditingController pages = TextEditingController(text: "1");
    TextEditingController lang = TextEditingController(text: book.language);
    TextEditingController audioLang =
        TextEditingController(text: book.audioLen);

    return Scaffold(
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
                            "UPDATE BOOK",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                          ),
                          SizedBox(width: 70)
                        ],
                      ),
                      SizedBox(height: 60),
                      InkWell(
                        onTap: () {
                          bookController.pickImage();
                        },
                        child: Container(
                          height: 190,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                book.coverUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                SizedBox(height: 10),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton(
                        value: categoryValue.value,
                        hint: Text("Select Category"),
                        items: [
                          DropdownMenuItem(
                            value: xclass,
                            child: Text("Xth Class"),
                          ),
                          DropdownMenuItem(
                            value: xiclass,
                            child: Text("XIth Class"),
                          ),
                          DropdownMenuItem(
                            value: xiiclass,
                            child: Text("XIIth Class"),
                          ),
                          DropdownMenuItem(
                            value: undergraduation,
                            child: Text("Under Graduction"),
                          ),
                          DropdownMenuItem(
                            value: postgraduation,
                            child: Text("Post Graduction"),
                          ),
                        ],
                        onChanged: (value) {
                          categoryValue.value = value!;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                MyTextFormField(
                  hintText: "Book title",
                  icon: Icons.book,
                  controller: title,
                ),
                SizedBox(height: 10),
                MultiLineTextField(
                    hintText: "Book Description", controller: des),
                SizedBox(height: 10),
                MyTextFormField(
                  hintText: "Author Name",
                  icon: Icons.person,
                  controller: author,
                ),
                SizedBox(height: 10),
                MyTextFormField(
                  hintText: "About Author",
                  icon: Icons.person,
                  controller: aboutAuthor,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: MyTextFormField(
                        isNumber: true,
                        hintText: "Price",
                        icon: Icons.currency_rupee,
                        controller: price,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: MyTextFormField(
                        hintText: "Pages",
                        isNumber: true,
                        icon: Icons.book,
                        controller: pages,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: MyTextFormField(
                        hintText: "Language",
                        icon: Icons.language,
                        controller: lang,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: MyTextFormField(
                        hintText: "Audio Len",
                        icon: Icons.audiotrack,
                        controller: audioLang,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: Colors.red,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "CANCLE",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.red,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            bookController.updateBook(
                              book.id!,
                              book.category!,
                              title.text,
                              des.text,
                              author.text,
                              aboutAuthor.text,
                              int.parse(price.text),
                              int.parse(pages.text),
                              lang.text,
                              audioLang.text,
                              book.coverUrl!,
                              book.bookurl!,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_sharp,
                                color: Theme.of(context).colorScheme.background,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "POST",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
