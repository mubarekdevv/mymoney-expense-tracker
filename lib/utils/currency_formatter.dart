String formatCurrency(
  double amount,
  String currency,
) {
  return '$currency ${amount.toStringAsFixed(2)}';
}
