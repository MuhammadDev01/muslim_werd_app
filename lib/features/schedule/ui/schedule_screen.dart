import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/core/theme/app_styles.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List<DateTime> generateDates() {
    DateTime now = DateTime.now();
    return List.generate(7, (index) => now.add(Duration(days: index))).toList();
  }

  final List<DateTime> dates = [];

  @override
  void initState() {
    super.initState();
    dates.addAll(generateDates());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Table(
          border: TableBorder.all(width: 2),

          defaultColumnWidth: FlexColumnWidth(10),
          // columnWidths:  Map<1, TableColumnWidth.>,
          //textDirection: TextDirection.RTL,
          children: [
            TableRow(
              decoration: BoxDecoration(color: AppColors.primary),
              children: [
                CustomTableCell(title: 'أذكار الصباح'),
                CustomTableCell(title: 'الورد اليومي'),
                CustomTableCell(title: 'أذكار المساء'),
                CustomTableCell(title: '/'),
              ],
            ),
            for (var date in dates)
              TableRow(
                children: [
                  TableCell(
                    child: InkWell(
                      onTap: () {},
                      child: Center(child: Text('taskMap[date]!.title')),
                    ),
                  ),
                  TableCell(
                    child: Checkbox(
                      activeColor: AppColors.primary,
                      checkColor: AppColors.white,
                      value: true,
                      onChanged: (_) {},
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Center(
                        child: Column(
                          children: [
                            Text(DateFormat.EEEE('ar').format(date)),
                            Text(DateFormat.MMMd('ar').format(date)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const TableCell(child: SizedBox.shrink()),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class CustomTableCell extends StatelessWidget {
  const CustomTableCell({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(title, style: TextStyles.uthman14Bold(context)),
        ),
      ),
    );
  }
}
