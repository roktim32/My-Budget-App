import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/db/db.dart';
import 'package:flutter_budget_ui/helpers/expenses_helper.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/screens/home_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Db.init(await getApplicationDocumentsDirectory());
  ExpensesHelper().addExpense(
    Expense(name: 'New expense', cost: 1200, dateTime: DateTime.now()),
    Category(name: 'New Category', maxAmount: 12000)
  );
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green.shade400,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
  @override
  void dispose() {
    Db.dispose();
    super.dispose();
  }
}
