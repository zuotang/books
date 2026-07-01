import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.trailingText,
    this.onTap,
  });

  final String title;
  final String? trailingText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: theme.textTheme.titleLarge,
        ),
        if (trailingText != null)
          TextButton(
            onPressed: onTap,
            child: Text(
              trailingText!,
              style: theme.textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}
