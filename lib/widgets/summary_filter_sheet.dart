import 'package:flutter/material.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';

class SummaryFilterSheet extends StatefulWidget {
  final ThemeData theme;
  final String title;
  final List<String> options;

  const SummaryFilterSheet({
    super.key,
    required this.theme,
    required this.title,
    required this.options,
  });

  @override
  _SummaryFilterSheetState createState() => _SummaryFilterSheetState();
}

class _SummaryFilterSheetState extends State<SummaryFilterSheet> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    // Initialize selected option if needed
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.theme.colorScheme.bgColor(),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select ${widget.title}',
                    style: widget.theme.textTheme.transactionSheetLabelBold
                        .copyWith(
                      color: widget.theme.colorScheme.textColor(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded,
                        color: widget.theme.colorScheme.textColor(), size: 24),
                    onPressed: () {
                      Navigator.pop(context, widget.title);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            // ...widget.options.map((option) => _buildOptionRow(option)),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  return _buildOptionRow(widget.options[index]);
                },
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, widget.title);
                    },
                    child: Text(
                      'Clear',
                      style: widget.theme.textTheme.summaryLabelBold.copyWith(
                        color: widget.theme.colorScheme.textColor(),
                      ),
                    ),
                  ),
                  MaterialButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context, _selectedOption);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.theme.colorScheme.secondaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 48),
                      child: Text(
                        'Apply',
                        style: widget.theme.textTheme.statsLabelBold.copyWith(
                          color: widget.theme.colorScheme.textColor(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionRow(String option) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = option;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                option,
                style: widget.theme.textTheme.summaryLabel.copyWith(
                  color: widget.theme.colorScheme.textColor(),
                ),
              ),
            ),
            Radio<String>(
              value: option,
              groupValue: _selectedOption,
              onChanged: (String? value) {
                setState(() {
                  _selectedOption = value;
                });
              },
              activeColor: widget.theme.colorScheme.secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
