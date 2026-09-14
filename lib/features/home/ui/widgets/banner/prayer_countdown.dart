import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PrayerCountdown extends StatelessWidget {
  final Duration remaining;
  final Color foreground;

  const PrayerCountdown({
    super.key,
    required this.remaining,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    final hours = remaining.inHours;

    final minutes = remaining.inMinutes.remainder(60);

    final seconds = remaining.inSeconds.remainder(60);

    return Align(
      alignment: Alignment.centerLeft,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
        decoration: BoxDecoration(
          color: foreground.withValues(alpha: .18),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: foreground.withValues(alpha: .35)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'متبقي على الصلاة القادمة',
              style: TextStyle(
                color: foreground.withValues(alpha: .9),
                fontSize: 10,
              ),
            ),

            const Gap(5),

            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: foreground,
                  size: 18,
                ),

                const Gap(7),

                Text(
                  '${_two(hours)}:'
                  '${_two(minutes)}:'
                  '${_two(seconds)}',
                  style: TextStyle(
                    color: foreground,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _two(int value) {
    return value.toString().padLeft(2, '0');
  }
}