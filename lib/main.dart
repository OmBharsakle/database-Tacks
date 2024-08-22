import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'View/HomePage/HomePage.dart';

void main()
{
  runApp(const BudgetTracker());
}

class BudgetTracker extends StatelessWidget {
  const BudgetTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => const HomePage(),),
      ],
    );
  }
}