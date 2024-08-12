import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:spend_wise/data/models/transaction_model.dart';
import 'package:spend_wise/viewModels/summary_view_model.dart';
import 'package:spend_wise/views/summary_screen.dart';
import 'package:spend_wise/widgets/transaction_item.dart';
import 'package:spend_wise/widgets/update_transaction_sheet.dart';

import 'summary_screen_test.mocks.dart';

@GenerateMocks([SummaryViewModel])
void main() {
  late MockSummaryViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockSummaryViewModel();
  });

  Future<void> buildSummaryScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<SummaryViewModel>.value(
          value: mockViewModel,
          child: const SummaryScreen(),
        ),
      ),
    );
  }

  testWidgets('Displays loading indicator when status is loading',
      (WidgetTester tester) async {
    when(mockViewModel.status).thenReturn(Status.loading);

    await buildSummaryScreen(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays error message when status is error',
      (WidgetTester tester) async {
    when(mockViewModel.status).thenReturn(Status.error);

    await buildSummaryScreen(tester);

    expect(find.text("Try again later!"), findsOneWidget);
  });

  testWidgets('Displays transactions when status is success',
      (WidgetTester tester) async {
    when(mockViewModel.status).thenReturn(Status.success);
    when(mockViewModel.transactions).thenReturn([
      // Sample transaction data
      TransactionModel(1, 100, 'Test title', 'Test Description',
          'Test Category', true, DateTime.now()),
    ]);

    await buildSummaryScreen(tester);

    expect(find.byType(TransactionItem), findsOneWidget);
  });

  testWidgets(
      'Clicking on a transaction should show the UpdateTransactionSheet',
      (WidgetTester tester) async {
    when(mockViewModel.status).thenReturn(Status.success);
    when(mockViewModel.transactions).thenReturn([
      TransactionModel(1, 100, 'Test title', 'Test Description',
          'Test Category', true, DateTime.now()),
    ]);

    await buildSummaryScreen(tester);

    // Swipe to edit (dismissible interaction)
    final transactionItem = find.byType(TransactionItem);
    expect(transactionItem, findsOneWidget);
    await tester.drag(transactionItem, const Offset(-500, 0));
    await tester.pumpAndSettle();

    // Verify that the UpdateTransactionSheet is displayed
    expect(find.byType(UpdateTransactionSheet), findsOneWidget);
  });

  testWidgets('Filter button interaction should call filterTransactions',
      (WidgetTester tester) async {
    when(mockViewModel.status).thenReturn(Status.success);
    when(mockViewModel.selectedCategory).thenReturn('Category');
    when(mockViewModel.categories).thenReturn(['Category1', 'Category2']);

    await buildSummaryScreen(tester);

    final filterButton = find.text('Category');
    expect(filterButton, findsOneWidget);

    await tester.tap(filterButton);
    await tester.pumpAndSettle();

    // Select a filter option
    final option = find.text('Category1').first;
    expect(option, findsOneWidget);
    await tester.tap(option);
    await tester.pumpAndSettle();

    // Verify that filterTransactions was called
    verify(mockViewModel.filterTransactions(selectedCategory: 'Category1'))
        .called(1);
  });
}
