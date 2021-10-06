import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Expense {
  @Id()
  int id=0;
  String name;
  double cost;
  @Property(type: PropertyType.date)
  DateTime dateTime;
  final category = ToOne<Category>();

  Expense({required this.name, required this.cost, required this.dateTime});
}
