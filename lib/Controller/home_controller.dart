import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../DataBase/db_helper.dart';

class HomeController extends GetxController
{
  @override
  void onInit()
  {
    super.onInit();
    initDb();
  }

  Future initDb()
  async {
    await DbHelper.dbHelper.database;
  }

  Future insertRecord(BuildContext context) async {
    TextEditingController priceCon = TextEditingController();
    TextEditingController expenseCon = TextEditingController();
    TextEditingController productCon = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Expenses"),
          content: Container(
            height: 200,
            child: Column(
              children: [
                TextField(
                  controller: priceCon,
                  decoration: InputDecoration(labelText: "Amount"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: expenseCon,
                  decoration: InputDecoration(labelText: "Is Income (0/1)"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: productCon,
                  decoration: InputDecoration(labelText: "Category"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Submit"),
              onPressed: () async {
                double? amount = double.tryParse(priceCon.text);
                int? isIncome = int.tryParse(expenseCon.text);
                String category = productCon.text;
                if (amount != null && isIncome != null && category.isNotEmpty) {
                  await DbHelper.dbHelper.insertData(amount, isIncome, category);
                  Navigator.of(context).pop();
                } else {
                  // Show an error message if the inputs are invalid
                  Get.snackbar("Error", "Please enter valid data");
                }
              },
            ),
          ],
        );
      },
    );
  }


}