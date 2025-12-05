import 'package:flutter/material.dart';

class JobFeedFilterOptionWidget<T> extends StatefulWidget {
  final IconData? icon;
  final List<IconData>? icons;
  final String label;
  final T value;
  final T? selectedValue;
  final ValueChanged<T> onSelected;
  final Color? selectedColor;
  final Color? unselectedBorderColor;
  final Color? iconColor;
  final double borderRadius;

  const JobFeedFilterOptionWidget({
    super.key,
    this.icon,
    this.icons,
    required this.label,
    required this.value,
    required this.selectedValue,
    required this.onSelected,
    this.selectedColor,
    this.unselectedBorderColor,
    this.iconColor,
    this.borderRadius = 30,
  });

  @override
  State<JobFeedFilterOptionWidget<T>> createState() =>
      _JobFeedFilterOptionWidgetState<T>();
}

class _JobFeedFilterOptionWidgetState<T>
    extends State<JobFeedFilterOptionWidget<T>> {
  bool get isSelected => widget.selectedValue == widget.value;

  @override
  Widget build(BuildContext context) {
    final effectiveSelectedColor = widget.selectedColor ?? Colors.blue[600]!;
    final effectiveUnselectedBorderColor =
        widget.unselectedBorderColor ?? Colors.grey[300]!;
    final effectiveIconColor = widget.iconColor ?? Colors.blue[600]!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () => widget.onSelected(widget.value),
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? effectiveSelectedColor
                  : effectiveUnselectedBorderColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Row(
            children: [
              // Icon(s)
              if (widget.icons != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.icons!.map((iconData) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(
                        iconData,
                        size: 20,
                        color: effectiveIconColor,
                      ),
                    );
                  }).toList(),
                )
              else if (widget.icon != null)
                Icon(widget.icon, size: 20, color: effectiveIconColor),
              const SizedBox(width: 12),
              // Label
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                ),
              ),
              // Radio indicator
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? effectiveSelectedColor
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: effectiveSelectedColor,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
