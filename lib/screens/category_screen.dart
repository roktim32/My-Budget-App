import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';

class CategoryScreen extends StatefulWidget {
  late final Category? category;

  CategoryScreen({this.category});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    double totalAmountSpent = 0;
    widget.category!.expenses!.forEach((Expense expense) {
      totalAmountSpent += expense.cost!;
    });

    final double amountLeft = widget.category!.maxAmount! - totalAmountSpent;
    final double percent = amountLeft / widget.category!.maxAmount!;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category!.name}'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            iconSize: 30.0,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              height: 250.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 6.0)
                ],
              ),
              child: Center(
                child: Text(
                    '\₹${amountLeft.toStringAsFixed(2)} / \₹${widget.category!.maxAmount!}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
