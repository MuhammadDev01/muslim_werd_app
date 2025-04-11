import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muslim_werd_app/core/theming/colors.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});
  List<DateTime> generateDates({required int days}) {
    DateTime now = DateTime.now();
    return List.generate(
      days,
      (index) => now.subtract(Duration(days: index)),
    ).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<DateTime> dates = generateDates(days: 7); // الأسبوع الحالي
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final isToday =
              date.day == DateTime.now().day &&
              date.month == DateTime.now().month &&
              date.year == DateTime.now().year;

          return Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isToday ? Colors.blue : Colors.grey[800],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.EEEE('ar').format(date), // Fri, Sat
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                    DateFormat.MMMMd('ar').format(date),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // SingleChildScrollView(

    //   child: Center(
    //     child: Padding(
    //       padding: const EdgeInsets.all(12),
    //       child: Table(
    //         border: TableBorder.all(width: 2),
    //         children: [
    //           TableRow(
    //             decoration: BoxDecoration(color: ColorsManager.tealWithOpacity),
    //             children: [
    //               TableCell(child: Text('data')),
    //               TableCell(child: Text('data')),
    //             ],
    //           ),
    //           TableRow(
    //             children: [
    //               TableCell(child: Text('data')),
    //               TableCell(child: Text('data')),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
