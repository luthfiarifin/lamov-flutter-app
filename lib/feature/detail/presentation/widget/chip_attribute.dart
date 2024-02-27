import '../../../../core/presentation/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChipAttribute extends StatelessWidget {
  final String name;
  final Icon? icon;
  final VoidCallback? onTap;

  const ChipAttribute(
    this.name, {
    super.key,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: FittedBox(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.onBackground.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                icon!,
                const Gap(4),
              ],
              Text(
                name,
                style: context.labelMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
