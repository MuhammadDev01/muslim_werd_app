import 'package:flutter/material.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/circle_icon.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, this.onSettingsTap, this.onNotificationsTap});

  final VoidCallback? onSettingsTap;
  final VoidCallback? onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 10),
      child: Row(
        children: [
          CircleIcon(
            icon: Icons.settings_outlined,
            onTap: onSettingsTap ?? () {},
          ),

          const Spacer(),

          CircleIcon(
            icon: Icons.notifications_none_rounded,
            onTap: onNotificationsTap ?? () {},
          ),
        ],
      ),
    );
  }
}