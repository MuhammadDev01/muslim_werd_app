import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class Ta7kkSourceFooter extends StatelessWidget {
  const Ta7kkSourceFooter({super.key});

  static const _dorarUrl = 'https://dorar.net';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.verified_user_outlined,
            size: 14,
            color: AppColors.darkTextSecondary,
          ),
          const Gap(6),
          Flexible(
            child: Text.rich(
              TextSpan(
                text: 'مصدر التحقق: ',
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: GestureDetector(
                      onTap: _openDorar,
                      child: Text(
                        'الدرر السنية',
                        style: TextStyle(
                          fontFamily: fontCairo,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontFamily: fontCairo,
                color: AppColors.darkTextSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openDorar() async {
    try {
      await launchUrl(
        Uri.parse(_dorarUrl),
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      // تجاهل أخطاء الفتح في البيئات غير المدعومة (مثل widget tests).
    }
  }
}
