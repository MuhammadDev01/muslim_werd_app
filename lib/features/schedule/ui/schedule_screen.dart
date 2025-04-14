import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muslim_werd_app/core/theming/styles.dart';

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

  // void toggleTask(DateTime date) {
  //   setState(() {
  //     taskMap[date]!.done = !taskMap[date]!.done;
  //   });
  // }

  // void editTask(DateTime date) async {
  //   final controller = TextEditingController();
  //   await showDialog(
  //     context: context,
  //     builder:
  //         (_) => AlertDialog(
  //           title: Text('تعديل المهمة'),
  //           content: TextField(
  //             controller: controller,
  //             decoration: InputDecoration(hintText: 'ادخل المهمة'),
  //           ),
  //           actions: [TextButton(child: Text('حفظ'), onPressed: () {})],
  //         ),
  //   );
  // }

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
              decoration: BoxDecoration(color: Colors.blue),
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
                      activeColor: Colors.teal,
                      checkColor: Colors.white,
                      value: true,
                      onChanged: (_) {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: TableCell(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              DateFormat.EEEE('ar').format(date),
                              style: TextStyles.uthman24Bold(context),
                            ),
                            Text(
                              DateFormat.MMMd('ar').format(date),
                              style: TextStyles.uthman24Bold(
                                context,
                              ).copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
