class CustomerSummary {
  final String code;
  final String name;
  final String milkType;
  final double totalMilk;
  final double totalValue;
  final double totalDeduction;
  final double netPayment;
  final Map<String, double> deductions;

  CustomerSummary({
    required this.code,
    required this.name,
    required this.milkType,
    required this.totalMilk,
    required this.totalValue,
    required this.totalDeduction,
    required this.netPayment,
    required this.deductions,
  });
}