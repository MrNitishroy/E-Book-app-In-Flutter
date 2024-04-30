import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/Config/ConstValue.dart';
import 'package:e_book/Config/Messages.dart';
import 'package:e_book/Models/BookModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class BookController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController auth = TextEditingController();
  TextEditingController aboutAuth = TextEditingController();
  TextEditingController pages = TextEditingController();
  TextEditingController audioLen = TextEditingController();
  TextEditingController language = TextEditingController();
  TextEditingController price = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  final fAuth = FirebaseAuth.instance;
  final uuid = Uuid();
  RxString imageUrl = "".obs;
  RxString pdfUrl = "".obs;
  RxBool isLoading = false.obs;
  int index = 0;
  RxBool isImageUploading = false.obs;
  RxBool isPdfUploading = false.obs;
  RxBool isPostUploading = true.obs;
  var bookData = RxList<BookModel>();
  var currentUserBooks = RxList<BookModel>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllBooks();
  }

  void getAllBooks() async {
    bookData.clear();
    successMessage("Book Get Fun");
    var books = await db.collection("Books").get();
    for (var book in books.docs) {
      bookData.add(BookModel.fromJson(book.data()));
    }
  }

  void getUserBook() async {
    currentUserBooks.clear();
    var books = await db
        .collection("userBook")
        .doc(fAuth.currentUser!.uid)
        .collection("Books")
        .get();
    for (var book in books.docs) {
      currentUserBooks.add(BookModel.fromJson(book.data()));
    }
  }

  Stream<List<BookModel>> getBookAsync() {
    return db.collection("Books").snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => BookModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<BookModel>> getCategoryBook(String categoryName) {
    return db.collection(categoryName).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => BookModel.fromJson(doc.data())).toList());
  }

  void pickImage() async {
    isImageUploading.value = true;
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image.path);
      uploadImageToFirebase(File(image.path));
    }
    isImageUploading.value = false;
  }

  void uploadImageToFirebase(File image) async {
    var uuid = Uuid();
    var filename = uuid.v1();
    var storageRef = storage.ref().child("Images/$filename");
    var response = await storageRef.putFile(image);
    String downloadURL = await storageRef.getDownloadURL();
    imageUrl.value = downloadURL;
    print("Download URL: $downloadURL");
    isImageUploading.value = false;
  }

  void createBook(String categoryIndex) async {
    isPostUploading.value = true;
    var id = uuid.v1();
    var categoryName = xclass;

    if (title.text.isNotEmpty &&
        des.text.isNotEmpty &&
        imageUrl.value.isNotEmpty &&
        pdfUrl.value.isNotEmpty &&
        auth.text.isNotEmpty &&
        categoryName.isNotEmpty &&
        price.text.isNotEmpty &&
        pages.text.isNotEmpty) {
      switch (categoryIndex) {
        case "10":
          {
            categoryName = xclass;
          }
          break;
        case "11":
          {
            categoryName = xiclass;
          }
          break;
        case "12":
          {
            categoryName = xiiclass;
          }
          break;
        case "13":
          {
            categoryName = undergraduation;
          }
          break;
        case "14":
          {
            categoryName = postgraduation;
          }
          break;
      }
      var newBook = BookModel(
        id: id,
        title: title.text,
        description: des.text,
        coverUrl: imageUrl.value,
        bookurl: pdfUrl.value,
        author: auth.text,
        category: categoryName,
        aboutAuthor: aboutAuth.text,
        price: int.parse(price.text),
        pages: int.parse(pages.text),
        language: language.text,
        audioLen: audioLen.text,
        audioUrl: "",
        rating: "",
      );
      await db.collection("Books").doc(id).set(newBook.toJson());
      await db.collection(categoryName).doc(id).set(newBook.toJson());
      addBookInUserDb(newBook, id);
      title.clear();
      des.clear();
      aboutAuth.clear();
      pages.clear();
      language.clear();
      audioLen.clear();
      auth.clear();
      price.clear();
      imageUrl.value = "";
      pdfUrl.value = "";
      successMessage("Book added");
      Get.back();
      getAllBooks();
      getUserBook();
      isPostUploading.value = false;
    } else {
      errorMessage("Please Fill all fields");
    }
  }

  void pickPDF() async {
    isPdfUploading.value = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.first.path!);

      if (file.existsSync()) {
        Uint8List fileBytes = await file.readAsBytes();
        String fileName = result.files.first.name;
        print("File Bytes: $fileBytes");

        final response =
            await storage.ref().child("Pdf/$fileName").putData(fileBytes);

        final downloadURL = await response.ref.getDownloadURL();
        pdfUrl.value = downloadURL;
        print(downloadURL);
      } else {
        print("File does not exist");
      }
    } else {
      print("No file selected");
    }
    isPdfUploading.value = false;
  }

  void addBookInUserDb(BookModel book, String id) async {
    await db
        .collection("userBook")
        .doc(fAuth.currentUser!.uid)
        .collection("Books")
        .doc(id)
        .set(book.toJson());
  }

  Future<void> deleteBook(String id, String category) async {
    print("deleteing Book");
    await db.collection("Books").doc(id).delete();
    await db.collection(category).doc(id).delete();
    Get.back();
  }

  Future<void> updateBook(
    String id,
    String category,
    String name,
    String des,
    String author,
    String authorDes,
    int price,
    int pages,
    String lang,
    String audioLang,
    String coverurl,
    String pdfUrl,
  ) async {
    isLoading.value = true;
    try {
      var newBook = BookModel(
        id: id,
        title: name,
        description: des,
        audioLen: audioLang,
        aboutAuthor: authorDes,
        price: price,
        pages: pages,
        language: lang,
        author: author,
        coverUrl: coverurl,
        bookurl: pdfUrl,
      );

      await db.collection("Books").doc(id).update(newBook.toJson());
      await db.collection(category).doc(id).update(newBook.toJson());
      successMessage("Done");
      getAllBooks();
      Get.back();
    } catch (ex) {
      errorMessage(ex.toString());
    }
    isLoading.value = false;
  }
}
