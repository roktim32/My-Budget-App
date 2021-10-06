import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/helpers/expenses_helper.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:intl/intl.dart';

class BarChart extends StatefulWidget {

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  Future<double> calculateExpenses(List<Expense>? expenses) async {
    double mostExpensive = 0;
    expenses!.forEach((Expense expense) {
      if (expense.cost > mostExpensive) {
        mostExpensive = expense.cost;
      }
    });
    return mostExpensive;
  }

  late DateTime startingDate;
  @override
  void initState() {
    startingDate = DateTime.now().subtract(Duration(days: DateTime.now().weekday));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Text(
            "Weekly Spending",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    startingDate = startingDate.subtract(Duration(days: 7));
                  });
                },
                icon: Icon(Icons.arrow_back),
                iconSize: 30.0,
              ),
              Text(
                // "Nov 11, 2021 - Nov 16, 2021",
                '${DateFormat('MMM dd, yyyy').format(startingDate)} - ${DateFormat('MMM dd, yyyy').format(startingDate.add(Duration(days: 6)))}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    startingDate = startingDate.add(Duration(days: 7));
                  });
                },
                icon: Icon(Icons.arrow_forward),
                iconSize: 30.0,
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          StreamBuilder<void>(
            stream: ExpensesHelper().listen(),
            builder: (context, snapshot) {
              return FutureBuilder<double>(
                  future: calculateExpenses(ExpensesHelper().read()),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    List<Expense> expenses = ExpensesHelper().read();
                    double mostExpensive = snapshot.data!;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Bar(
                          label: 'Su',
                          amountSpent: ExpensesHelper().totalExpenseInGivenDate(startingDate),
                          mostExpensive: mostExpensive,
                        ),
                        Bar(
                          label: 'Mo',
                          amountSpent: ExpensesHelper().totalExpenseInGivenDate(startingDate.add(Duration(days: 1))),
                          mostExpensive: mostExpensive,
                        ),
                        Bar(
                          label: 'Tu',
                          amountSpent: ExpensesHelper().totalExpenseInGivenDate(startingDate.add(Duration(days: 2))),
                          mostExpensive: mostExpensive,
                        ),
                        Bar(
                          label: 'We',
                          amountSpent: ExpensesHelper().totalExpenseInGivenDate(startingDate.add(Duration(days: 3))),
                          mostExpensive: mostExpensive,
                        ),
                        Bar(
                          label: 'Th',
                          amountSpent: ExpensesHelper().totalExpenseInGivenDate(startingDate.add(Duration(days: 4))),
                          mostExpensive: mostExpensive,
                        ),
                        Bar(
                          label: 'Fr',
                          amountSpent: ExpensesHelper().totalExpenseInGivenDate(startingDate.add(Duration(days: 5))),
                          mostExpensive: mostExpensive,
                        ),
                        Bar(
                          label: 'Sa',
                          amountSpent: ExpensesHelper().totalExpenseInGivenDate(startingDate.add(Duration(days: 6))),
                          mostExpensive: mostExpensive,
                        ),
                      ],
                    );
                  });
            }
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  late final String? label;
  late final double? amountSpent;
  late final double? mostExpensive;
  late final double? maxBarHeight = 150.0;

  Bar({this.label, this.amountSpent, this.mostExpensive});
  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent! / mostExpensive! * maxBarHeight!;
    return Column(
      children: <Widget>[
        Text(
          '\₹${amountSpent!.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 6.0,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 200,
            minHeight: 2
          ),
          child: Container(
            height: barHeight,
            width: 18.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          "$label",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
