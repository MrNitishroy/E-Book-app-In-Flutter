import 'package:e_book/Components/BackButton.dart';
import 'package:e_book/Components/MutiLineTextFormField.dart';
import 'package:e_book/Components/MyTextFormField.dart';
import 'package:e_book/Config/Colors.dart';
import 'package:e_book/Controller/BookController.dart';
import 'package:e_book/Controller/PdfController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewBookPage extends StatelessWidget {
  const AddNewBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    PdfController pdfController = Get.put(PdfController());
    BookController bookController = Get.put(BookController());
    RxString categoryValue = "10".obs;
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
                            "ADD NEW BOOK",
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
                          child: Obx(
                            () => Container(
                              height: 190,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Center(
                                child: bookController.isImageUploading.value
                                    ? CircularProgressIndicator(
                                        color: primaryColor,
                                      )
                                    : bookController.imageUrl.value == ""
                                        ? Image.asset(
                                            "Assets/Icons/addImage.png")
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              bookController.imageUrl.value,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                              ),
                            ),
                          )),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: bookController.pdfUrl.value == ""
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: bookController.isPdfUploading.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: backgroudColor,
                                  ),
                                )
                              : bookController.pdfUrl.value == ""
                                  ? InkWell(
                                      onTap: () {
                                        bookController.pickPDF();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              "Assets/Icons/upload.png"),
                                          SizedBox(width: 8),
                                          Text(
                                            "Book PDF",
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
                                    )
                                  : InkWell(
                                      onTap: () {
                                        bookController.pdfUrl.value = "";
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "Assets/Icons/delete.png",
                                            width: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "Delete Pdf",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Obx(
                  () => Row(
                    children: [
                      DropdownButton(
                        value: categoryValue.value,
                        hint: Text("Select Category"),
                        items: const [
                          DropdownMenuItem(
                            value: '10',
                            child: Text("Xth Class"),
                          ),
                          DropdownMenuItem(
                            value: '11',
                            child: Text("XIth Class"),
                          ),
                          DropdownMenuItem(
                            value: '12',
                            child: Text("XIIth Class"),
                          ),
                          DropdownMenuItem(
                            value: '13',
                            child: Text("Under Graduction"),
                          ),
                          DropdownMenuItem(
                            value: '14',
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
                  controller: bookController.title,
                ),
                SizedBox(height: 10),
                MultiLineTextField(
                    hintText: "Book Description",
                    controller: bookController.des),
                SizedBox(height: 10),
                MyTextFormField(
                  hintText: "Author Name",
                  icon: Icons.person,
                  controller: bookController.auth,
                ),
                SizedBox(height: 10),
                MyTextFormField(
                  hintText: "About Author",
                  icon: Icons.person,
                  controller: bookController.aboutAuth,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: MyTextFormField(
                        isNumber: true,
                        hintText: "Price",
                        icon: Icons.currency_rupee,
                        controller: bookController.price,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: MyTextFormField(
                        hintText: "Pages",
                        isNumber: true,
                        icon: Icons.book,
                        controller: bookController.pages,
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
                        controller: bookController.language,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: MyTextFormField(
                        hintText: "Audio Len",
                        icon: Icons.audiotrack,
                        controller: bookController.audioLen,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
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
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child: Obx(
                      () => Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: bookController.isPdfUploading.value
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : InkWell(
                                onTap: () {
                                  bookController
                                      .createBook(categoryValue.value);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload_sharp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
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
                    )),
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
