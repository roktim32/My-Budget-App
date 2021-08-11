import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 1)
class Category {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final double? maxAmount;
  @HiveField(2)
  final List<Expense>? expenses;

  Category({this.name, this.maxAmount, this.expenses});
}
