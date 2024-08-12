import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';
import 'package:spend_wise/widgets/add_transaction_sheet.dart';
import 'package:spend_wise/widgets/top_spending_item.dart';
import 'package:spend_wise/widgets/transaction_item.dart';
import 'package:spend_wise/widgets/update_transaction_sheet.dart';
import '../data/repositories/transaction_repository.dart';
import '../utils/routes/routes_names.dart';
import '../viewModels/home_view_model.dart';
import '../widgets/stats_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TransactionRepository _expenseRepository;
  late final HomeViewModel _homeViewModel;

  @override
  void initState() {
    super.initState();
    _expenseRepository = TransactionRepository();
    _homeViewModel = HomeViewModel(_expenseRepository);
    _homeViewModel.fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.bgColor(),
      body: SafeArea(
        child: ChangeNotifierProvider<HomeViewModel>(
          create: (context) => _homeViewModel,
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
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header Section
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor:
                                        theme.colorScheme.primaryColor,
                                    child: Icon(Icons.person_rounded,
                                        color: theme.colorScheme.secondaryColor,
                                        size: 30),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hello Selva',
                                        style: theme.textTheme.greetingsBold
                                            .copyWith(
                                          color: theme.colorScheme.textColor(),
                                        ),
                                      ),
                                      Text(
                                        'Good Morning',
                                        style: theme.textTheme.greetingsNormal
                                            .copyWith(
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
                                expense: _homeViewModel.totalExpense,
                                income: _homeViewModel.totalIncome,
                              ),
                              const SizedBox(height: 20),
                              // Top Spending Section
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteNames.summaryScreen,
                                      arguments: "Category");
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Top Spendings',
                                      style: theme.textTheme.homeLabelBold
                                          .copyWith(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  Navigator.pushNamed(
                                      context, RouteNames.summaryScreen,
                                      arguments: "Category");
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Recent Transactions',
                                      style: theme.textTheme.homeLabelBold
                                          .copyWith(
                                        color: theme.colorScheme.textColor(),
                                      ),
                                    ),
                                    Text(
                                      'View all',
                                      style: theme.textTheme.homeLabelNormal
                                          .copyWith(
                                        color: theme.colorScheme.textColor(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: value.transaction.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: Key(
                                        value.transaction[index].id.toString()),
                                    confirmDismiss: (direction) async {
                                      // Handle deletion logic
                                      print("Dismissible :$direction");
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        final result =
                                            await showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                              ),
                                              child: UpdateTransactionSheet(
                                                theme: theme,
                                                title: value
                                                    .transaction[index].title
                                                    .toString(),
                                                description: value
                                                    .transaction[index]
                                                    .description
                                                    .toString(),
                                                category: value
                                                    .transaction[index].category
                                                    .toString(),
                                                amount: value
                                                    .transaction[index].amount
                                                    .toString(),
                                                isExpense: value
                                                    .transaction[index]
                                                    .isExpense,
                                              ),
                                            );
                                          },
                                        );

                                        if (result != null && mounted) {
                                          _homeViewModel.updateTransaction(
                                            value.transaction[index].id,
                                            result['title']!,
                                            result['description']!,
                                            result['category']!,
                                            result['amount']!,
                                            result['isExpense'],
                                          );
                                        }

                                        return false;
                                      } else {
                                        _homeViewModel.deleteTransaction(
                                            value.transaction[index].id);

                                        return true;
                                      }
                                    },
                                    background: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        // Red background for left swipe
                                        borderRadius: BorderRadius.circular(
                                            12.0), // Rounded corners
                                      ),
                                      child: const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Icon(Icons.delete,
                                              color:
                                                  Colors.white), // Delete icon
                                        ),
                                      ),
                                    ),
                                    secondaryBackground: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.orangeAccent,
                                        // Green background for right swipe
                                        borderRadius: BorderRadius.circular(
                                            12.0), // Rounded corners
                                      ),
                                      child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Icon(Icons.edit_rounded,
                                              color:
                                                  Colors.white), // Check icon
                                        ),
                                      ),
                                    ),
                                    child: TransactionItem(
                                      theme: theme,
                                      icon: _homeViewModel.getIcons(
                                          value.transaction[index].category),
                                      title: value.transaction[index].title,
                                      subtitle:
                                          value.transaction[index].description,
                                      amount: value.transaction[index].amount
                                          .toString(),
                                      isExpense:
                                          value.transaction[index].isExpense,
                                    ),
                                  );
                                },
                              ),
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
          final result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddTransactionSheet(theme: theme),
              );
            },
          );

          if (result != null && mounted) {
            _homeViewModel.addTransaction(
              result['title']!,
              result['description']!,
              result['category']!,
              result['amount']!,
              result['isExpense'],
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
