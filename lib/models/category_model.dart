import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Category {
  @Id()
  int id=0;
  String name;
  double maxAmount;
  @Backlink()
  final expenses = ToMany<Expense>();

  Category({required this.name, required this.maxAmount});
}
