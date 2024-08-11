import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spend_wise/repositories/expense_repository.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';
import 'package:spend_wise/widgets/add_expense_sheet.dart';
import 'package:spend_wise/widgets/top_spending_item.dart';
import 'package:spend_wise/widgets/transaction_item.dart';
import '../models/expense.dart';
import '../viewModels/home_view_model.dart';
import '../viewmodels/splash_service.dart';
import '../widgets/stats_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ExpenseRepository _expenseRepository;

  @override
  void initState() {
    super.initState();
    _expenseRepository = ExpenseRepository();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.colorScheme.bgColor(),
      body: SafeArea(
        child: ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(_expenseRepository),
          child: Consumer<HomeViewModel>(
            builder: (context, value, child) {
              switch (value.status) {
                case 1:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  );
                case 2:
                  return const Center(
                    child: Text(
                      "Something went wrong!",
                    ),
                  );
                case 3:
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Section
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: theme.colorScheme.primaryColor,
                              child: Icon(Icons.person_rounded,
                                  color: theme.colorScheme.secondaryColor,
                                  size: 30),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello Selva',
                                  style: theme.textTheme.greetingsBold.copyWith(
                                    color: theme.colorScheme.textColor(),
                                  ),
                                ),
                                Text(
                                  'Good Morning',
                                  style:
                                      theme.textTheme.greetingsNormal.copyWith(
                                    color: theme.colorScheme.textColor(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        StatsCard(
                          theme: theme,
                          balance: "45000",
                          expense: "25000",
                          income: "45000",
                        ),
                        const SizedBox(height: 20),
                        // Top Spending Section
                        GestureDetector(
                          onTap: () {
                            print("Top Spending Tapped");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Top Spending\'s',
                                style: theme.textTheme.homeLabelBold.copyWith(
                                  color: theme.colorScheme.textColor(),
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_right,
                                  color: theme.colorScheme.textColor(),
                                  size: 30),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TopSpendingItem(
                                theme: theme,
                                icon: Icons.fastfood,
                                title: "Food"),
                            TopSpendingItem(
                                theme: theme,
                                icon: Icons.local_gas_station,
                                title: 'Fuel'),
                            TopSpendingItem(
                                theme: theme,
                                icon: Icons.flight,
                                title: "Travel"),
                            TopSpendingItem(
                                theme: theme,
                                icon: Icons.shopping_cart,
                                title: "Shopping"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Recent Transactions Section
                        GestureDetector(
                          onTap: () {
                            print("Recent transaction Tapped");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recent Transactions',
                                style: theme.textTheme.homeLabelBold.copyWith(
                                  color: theme.colorScheme.textColor(),
                                ),
                              ),
                              Text(
                                'View all',
                                style: theme.textTheme.homeLabelNormal.copyWith(
                                  color: theme.colorScheme.textColor(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView(
                            children: [
                              TransactionItem(
                                  theme: theme,
                                  icon: Icons.shopping_bag,
                                  title: 'Grocery Shopping',
                                  subtitle: 'Nilgiri\'s',
                                  amount: '- ₹ 50',
                                  isExpense: true),
                              TransactionItem(
                                  theme: theme,
                                  icon: Icons.local_dining,
                                  title: 'Food & Drinks',
                                  subtitle: 'Pizza and Cold coffee',
                                  amount: '- ₹ 450',
                                  isExpense: true),
                              TransactionItem(
                                  theme: theme,
                                  icon: Icons.subscriptions,
                                  title: 'Bills & Subscription',
                                  subtitle: 'Amazon Prime Monthly',
                                  amount: '- ₹ 150',
                                  isExpense: true),
                              TransactionItem(
                                  theme: theme,
                                  icon: Icons.flight,
                                  title: 'Travel',
                                  subtitle: 'Bus to Mysore',
                                  amount: '- ₹ 350',
                                  isExpense: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.colorScheme.secondaryColor,
        onPressed: () async {
          // Add your onPressed code here!
          print('Add button pressed');

          final viewModel = Provider.of<HomeViewModel>(context, listen: false);
          final theme = Theme.of(context);

          final result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddExpenseSheet(theme: theme),
              );
            },
          );

          if (result != null && mounted) {
            viewModel.addExpense(
              result['title']!,
              result['description']!,
              result['category']!,
              result['amount']!,
            );
          }
        },
        tooltip: 'Add',
        child: Icon(
          Icons.add,
          color: theme.colorScheme.textColor(),
        ),
      ),
    );
  }
}
