import 'package:hive/hive.dart';
part 'expense_model.g.dart';

@HiveType(typeId: 0)
class Expense {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final double? cost;

  Expense({this.name, this.cost});
}
