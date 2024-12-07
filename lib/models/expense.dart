import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter =
    DateFormat.yMd(); // hàm này giúp format ngày theo định dạng đeer có thể
// hiển thị lên được màn hình nếu khôgn sử dụng nó thì sẽ không hiển thị lên được
// hoặc có lỗi và kiểu hiển thị của nó là ngày tháng năm

const uuid = Uuid();

enum Categories { food, travel, leisure, work }

const categoryIcons = {
  Categories.food: Icons.lunch_dining,
  Categories.travel: Icons.flight_takeoff,
  Categories.leisure: Icons.movie,
  Categories.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  String get formattedDate => formatter.format(date);
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.categories,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.categories)
      : expenses = allExpenses
            .where((expense) => expense.category == categories)
            .toList();
  final Categories categories;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
