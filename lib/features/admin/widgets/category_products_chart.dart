import 'package:charts_flutter_updated/charts_flutter_updated.dart' as charts;
import 'package:flutter/material.dart';
import 'package:prismcart/features/admin/models/sales.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;
  const CategoryProductsChart({
    super.key,
    required this.seriesList,
  });

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}