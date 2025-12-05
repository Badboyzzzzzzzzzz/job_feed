import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_feed/presentation/screen/theme/job_post_app_theme.dart';
import 'package:job_feed/presentation/screen/widget/job_feed_filter_option_widget.dart';

/// A reusable filter dialog that can be used for different filter types.
class JobFeedFilterDialog<T> extends StatefulWidget {
  final List<T> items;
  final T? initialSelection;
  final String title;
  final IconData titleIcon;
  final String Function(T item) getItemName;
  final Function(T?)? onApply;

  const JobFeedFilterDialog({
    super.key,
    required this.items,
    this.initialSelection,
    required this.title,
    required this.titleIcon,
    required this.getItemName,
    this.onApply,
  });

  /// Show the filter dialog as a modal bottom sheet
  static Future<T?> show<T>(
    BuildContext context, {
    required List<T> items,
    T? initialSelection,
    required String title,
    required IconData titleIcon,
    required String Function(T item) getItemName,
  }) async {
    return showModalBottomSheet<T?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => JobFeedFilterDialog<T>(
        items: items,
        initialSelection: initialSelection,
        title: title,
        titleIcon: titleIcon,
        getItemName: getItemName,
      ),
    );
  }

  @override
  State<JobFeedFilterDialog<T>> createState() => _JobFeedFilterDialogState<T>();
}

class _JobFeedFilterDialogState<T> extends State<JobFeedFilterDialog<T>> {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: JobPostAppTheme.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(widget.titleIcon, color: Colors.blue[600], size: 24),
                const SizedBox(width: 10),
                Text(
                  widget.title,
                  style: GoogleFonts.notoSansKhmer(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Filter options
          if (widget.items.isEmpty)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'មិនមានទិន្នន័យ',
                style: GoogleFonts.notoSansKhmer(color: Colors.grey[600]),
              ),
            )
          else
            ...widget.items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: JobFeedFilterOptionWidget<T>(
                  label: widget.getItemName(item),
                  value: item,
                  selectedValue: _selectedItem,
                  onSelected: (value) {
                    setState(() {
                      _selectedItem = value;
                    });
                  },
                ),
              );
            }),
          const SizedBox(height: 12),

          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selectedItem = null;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Clear',
                      style: GoogleFonts.notoSansKhmer(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(_selectedItem);
                      widget.onApply?.call(_selectedItem);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Apply',
                      style: GoogleFonts.notoSansKhmer(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
        ],
      ),
    );
  }
}
