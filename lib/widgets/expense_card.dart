import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/helpers/color_helper.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/screens/category_screen.dart';

class ExpenseCard extends StatelessWidget {
  final Category category;
  const ExpenseCard({ required this.category, Key? key }) : super(key: key);

  Future<double> calculateTotalExpense() async {
    double totalAmountSpent = 0;
    category.expenses.forEach((Expense expence) {
      totalAmountSpent += expence.cost;
    });
    return totalAmountSpent;
  }

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CategoryScreen(category: category),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: FutureBuilder<double>(
          future: calculateTotalExpense(),
          builder: (context, snapshot) {
            if(snapshot.connectionState!=ConnectionState.done){
              return Container();
            }
            double totalAmountSpent = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      category.name,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\₹${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)}/ \₹${category.maxAmount.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final double maxBarWidth = constraints.maxWidth;
                    final double percent =
                        (category.maxAmount - totalAmountSpent) /
                            category.maxAmount;
                    double barWidth = percent * maxBarWidth;
        
                    if (barWidth < 0) {
                      barWidth = 0;
                    }
                    return Stack(
                      children: <Widget>[
                        Container(
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        Container(
                          height: 20.0,
                          width: barWidth,
                          decoration: BoxDecoration(
                            color: getColor(context, percent),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}