import "package:flutter/material.dart";

import '../../config/theme/app_colors.dart';

enum AppButtonVariant { primary, secondary, ghost }

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.leading,
    this.trailing,
    this.expand = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final Widget? leading;
  final Widget? trailing;
  final bool expand;
  final EdgeInsetsGeometry padding;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  Color _backgroundColor() {
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return AppColors.primary;
      case AppButtonVariant.secondary:
        return AppColors.surface;
      case AppButtonVariant.ghost:
        return Colors.transparent;
    }
  }

  Color _foregroundColor() {
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return Colors.white;
      case AppButtonVariant.secondary:
        return AppColors.textPrimary;
      case AppButtonVariant.ghost:
        return AppColors.textPrimary;
    }
  }

  BorderSide _border() {
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return BorderSide.none;
      case AppButtonVariant.secondary:
        return const BorderSide(color: AppColors.border);
      case AppButtonVariant.ghost:
        return const BorderSide(color: Colors.transparent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final labelStyle = textTheme.labelLarge?.copyWith(
      color: _foregroundColor(),
      fontWeight: FontWeight.w600,
    );

    final child = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.leading != null) ...[
          widget.leading!,
          const SizedBox(width: 12),
        ],
        Flexible(
          child: Text(
            widget.label,
            style: labelStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (widget.trailing != null) ...[
          const SizedBox(width: 12),
          widget.trailing!,
        ],
      ],
    );

    return AnimatedScale(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      scale: _pressed ? 0.98 : 1,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: widget.onPressed == null ? 0.6 : 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _backgroundColor(),
            borderRadius: BorderRadius.circular(20),
            border: Border.fromBorderSide(_border()),
            boxShadow: widget.variant == AppButtonVariant.primary
                ? const [
                    BoxShadow(
                      color: AppColors.shadow,
                      offset: Offset(0, 12),
                      blurRadius: 24,
                    ),
                  ]
                : const [],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              onTapDown: (_) => setState(() => _pressed = true),
              onTapCancel: () => setState(() => _pressed = false),
              onTapUp: (_) => setState(() => _pressed = false),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: widget.padding,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppIconButton extends StatefulWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.isTonal = false,
    this.size = 48,
    this.backgroundColor,
    this.foregroundColor,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final bool isTonal;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final background = widget.backgroundColor ?? (widget.isTonal ? AppColors.surfaceMuted : Colors.white);
    final border = widget.isTonal ? Colors.transparent : AppColors.border;
    final iconColor = widget.foregroundColor ?? (widget.isTonal ? AppColors.primary : AppColors.textPrimary);

    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: _pressed ? 0.94 : 1,
      child: Material(
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.size / 2.2),
          side: BorderSide(color: border),
        ),
        elevation: 0,
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(widget.size / 2.2),
          onTapDown: (_) => setState(() => _pressed = true),
          onTapCancel: () => setState(() => _pressed = false),
          onTapUp: (_) => setState(() => _pressed = false),
          child: SizedBox(
            height: widget.size,
            width: widget.size,
            child: IconTheme(
              data: IconThemeData(color: iconColor),
              child: Center(child: widget.icon),
            ),
          ),
        ),
      ),
    );
  }
}
