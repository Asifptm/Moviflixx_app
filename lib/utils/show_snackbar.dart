import 'package:flutter/material.dart';

class CustomSnackBarWidget extends StatelessWidget {
  final IconData icon;
  final String reason;
  final Color color;
  final Color? iconBgColor;
  final Color? borderColor;

  const CustomSnackBarWidget({
    super.key,
    required this.icon,
    required this.reason,
    required this.color,
    this.iconBgColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveIconBgColor = iconBgColor ?? color.withOpacity(0.12);
    final Color effectiveBorderColor = borderColor ?? color.withOpacity(0.22);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: effectiveBorderColor, width: 1.3),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.10),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: effectiveIconBgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.18),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reason,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.5,
                    letterSpacing: 0.15,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  height: 3,
                  width: 40,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showCustomSnackBar(
  BuildContext context, {
  required IconData icon,
  required String reason,
  required Color color,
  Color? iconBgColor,
  Color? borderColor,
  Duration duration = const Duration(seconds: 4),
}) {
  final snackBar = SnackBar(
    content: CustomSnackBarWidget(
      icon: icon,
      reason: reason,
      color: color,
      iconBgColor: iconBgColor,
      borderColor: borderColor,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    duration: duration,
    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
