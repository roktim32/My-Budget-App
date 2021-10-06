import 'package:flutter_budget_ui/db/db.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/objectbox.g.dart';

class ExpensesHelper {
  List<Expense> read() {
    return Db.store!.box<Expense>().getAll();
  }

  void addExpense(Expense expense, Category category) {
    Box<Expense> box = Db.store!.box<Expense>();
    expense.category.target = category;
    box.put(expense);
  }

  List<Expense> readFromCat(Category category) {
    Box<Expense> box = Db.store!.box<Expense>();
    final query = box.query();
    query.link(Expense_.category, Category_.id.equals(category.id));
    final builder = query.build();
    final result = builder.find();
    builder.close();
    return result;
  }

  List<Category> readAllCategories() {
    Box<Category> box = Db.store!.box<Category>();
    return box.getAll();
  }

  double totalExpenseInGivenDate(DateTime dateTime) {
    Box<Expense> box = Db.store!.box<Expense>();
    final query = box.getAll();
    query.retainWhere((element) => element.dateTime.day == dateTime.day );
    double totalExpense = 0;
    query.forEach((element) {
      totalExpense += element.cost;
    });
    return totalExpense;
  }

  int categoryCount() {
    Box<Category> box = Db.store!.box<Category>();
    return box.count();
  }

  Stream listen(){
    return Db.store!.watch<Expense>();
  }
}