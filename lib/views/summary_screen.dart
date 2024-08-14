import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';
import 'package:spend_wise/viewModels/summary_view_model.dart';
import '../data/repositories/transaction_repository.dart';
import '../widgets/summary_filter_sheet.dart';
import '../widgets/transaction_item.dart';
import '../widgets/update_transaction_sheet.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  late SummaryViewModel _summaryViewModel;

  @override
  void initState() {
    super.initState();
    _summaryViewModel = SummaryViewModel(TransactionRepository());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = ModalRoute.of(context);
      if (route != null) {
        final String category = route.settings.arguments as String? ?? '';
        _summaryViewModel.setCategory(category);
        _summaryViewModel.fetchTransactions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded,
              color: theme.colorScheme.textColor()),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: theme.colorScheme.bgColor(),
      ),
      backgroundColor: theme.colorScheme.bgColor(),
      body: ChangeNotifierProvider<SummaryViewModel>.value(
        value: _summaryViewModel,
        child: Consumer<SummaryViewModel>(
          builder: (context, value, child) {
            switch (value.status) {
              case Status.loading:
                return const Center(
                    child: CircularProgressIndicator(color: Colors.grey));
              case Status.error:
                return const Center(child: Text("Try again later!"));
              case Status.success:
                return _buildSummaryContent(context, value, theme);
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildSummaryContent(
      BuildContext context, SummaryViewModel value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterRow(context, value, theme),
            const SizedBox(height: 16),
            _buildTransactionList(context, value, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterRow(
      BuildContext context, SummaryViewModel value, ThemeData theme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildFilterButton(
            context,
            theme,
            "Type",
            value.selectedType,
            value.types,
            (result) => value.filterTransactions(selectedType: result),
          ),
          const SizedBox(width: 16),
          _buildFilterButton(
            context,
            theme,
            "Category",
            value.selectedCategory,
            value.categories,
            (result) => value.filterTransactions(selectedCategory: result),
          ),
          const SizedBox(width: 16),
          _buildFilterButton(
            context,
            theme,
            "Period",
            value.selectedPeriod,
            value.periods,
            (result) => value.filterTransactions(selectedPeriod: result),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
    BuildContext context,
    ThemeData theme,
    String title,
    String selectedValue,
    List<String> options,
    Function(String) onSelected,
  ) {
    return OutlinedButton(
      onPressed: () async {
        final result = await showModalBottomSheet<String>(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => SummaryFilterSheet(
            theme: theme,
            title: title,
            options: options,
          ),
        );
        if (result != null) onSelected(result);
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: theme.colorScheme.textColor()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Row(
        children: [
          Text(
            selectedValue,
            style: theme.textTheme.summaryLabel.copyWith(
              color: theme.colorScheme.textColor(),
            ),
          ),
          Icon(Icons.arrow_drop_down, color: theme.colorScheme.textColor()),
        ],
      ),
    );
  }

  Widget _buildTransactionList(
      BuildContext context, SummaryViewModel value, ThemeData theme) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: value.transactions.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(value.transactions[index].id),
          confirmDismiss: (direction) =>
              _handleDismiss(context, direction, value, index),
          background: _buildDismissBackground(
              Colors.red, Icons.delete, Alignment.centerLeft),
          secondaryBackground: _buildDismissBackground(
              Colors.orangeAccent, Icons.edit_rounded, Alignment.centerRight),
          child: TransactionItem(
            theme: theme,
            icon: value.getIconForCategory(value.transactions[index].category),
            title: value.transactions[index].title,
            subtitle: value.transactions[index].description,
            amount: value.transactions[index].amount.toString(),
            isExpense: value.transactions[index].isExpense,
          ),
        );
      },
    );
  }

  Future<bool> _handleDismiss(BuildContext context, DismissDirection direction,
      SummaryViewModel value, int index) async {
    if (direction == DismissDirection.endToStart) {
      final result = await showModalBottomSheet<Map<String, dynamic>>(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: UpdateTransactionSheet(
            theme: Theme.of(context),
            title: value.transactions[index].title,
            description: value.transactions[index].description,
            category: value.transactions[index].category,
            amount: value.transactions[index].amount.toString(),
            isExpense: value.transactions[index].isExpense,
          ),
        ),
      );
      if (result != null && mounted) {
        value.updateTransaction(
          id: value.transactions[index].id,
          title: result['title']!,
          desc: result['description']!,
          category: result['category']!,
          amount: result['amount']!,
          isExpense: result['isExpense'],
        );
      }
      return false;
    } else {
      value.deleteTransaction(value.transactions[index].id);
      return true;
    }
  }

  Widget _buildDismissBackground(
      Color color, IconData icon, Alignment alignment) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
