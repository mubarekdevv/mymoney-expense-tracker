import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mymoney/services/prefs_service.dart';
import 'package:mymoney/utils/currency_formatter.dart';

import '../models/expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback onTap;

  const ExpenseTile({
    super.key,
    required this.expense,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMd().format(expense.date);

    return FutureBuilder<String>(
      future: PrefsService.getCurrency(),
      builder: (context, snapshot) {
        final currency = snapshot.data ?? 'ETB';

        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          child: ListTile(
            onTap: onTap,
            leading: CircleAvatar(
              child: Text(
                expense.category[0].toUpperCase(),
              ),
            ),
            title: Text(expense.category),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(expense.note),
                Text(formattedDate),
              ],
            ),
            trailing: Text(
              formatCurrency(
                expense.amount,
                currency,
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    final value = category.toLowerCase();

    if (value.contains('food')) {
      return Icons.restaurant;
    }

    if (value.contains('transport')) {
      return Icons.directions_car;
    }

    if (value.contains('shopping')) {
      return Icons.shopping_bag;
    }

    if (value.contains('health')) {
      return Icons.health_and_safety;
    }

    return Icons.attach_money;
  }
}
