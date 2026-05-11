import 'package:flutter/material.dart';
import 'package:mymoney/services/prefs_service.dart';
import 'package:mymoney/utils/currency_formatter.dart';

class MonthlyTotalCard extends StatelessWidget {
  final double total;

  const MonthlyTotalCard({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'This Month',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            FutureBuilder<String>(
              future: PrefsService.getCurrency(),
              builder: (context, snapshot) {
                final currency = snapshot.data ?? 'ETB';

                return Text(
                  formatCurrency(total, currency),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
