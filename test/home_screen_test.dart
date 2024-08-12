import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:spend_wise/viewModels/home_view_model.dart';
import 'package:spend_wise/views/home_screen.dart';
import 'package:spend_wise/widgets/add_transaction_sheet.dart';
import 'package:spend_wise/widgets/stats_card.dart';

// Mock classes
class MockHomeViewModel extends Mock implements HomeViewModel {}

void main() {
  late HomeViewModel mockHomeViewModel;

  setUp(() {
    mockHomeViewModel = MockHomeViewModel();
  });

  testWidgets(
      'HomeScreen displays CircularProgressIndicator when status is loading',
      (WidgetTester tester) async {
    // Arrange
    when(mockHomeViewModel.status).thenReturn(1); // Loading status

    // Act
    await tester.pumpWidget(
      ChangeNotifierProvider<HomeViewModel>.value(
        value: mockHomeViewModel,
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('HomeScreen displays error message when status is error',
      (WidgetTester tester) async {
    // Arrange
    when(mockHomeViewModel.status).thenReturn(2); // Error status

    // Act
    await tester.pumpWidget(
      ChangeNotifierProvider<HomeViewModel>.value(
        value: mockHomeViewModel,
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    // Assert
    expect(find.text('Something went wrong!'), findsOneWidget);
  });

  testWidgets('HomeScreen displays content when status is success',
      (WidgetTester tester) async {
    // Arrange
    when(mockHomeViewModel.status).thenReturn(3); // Success status
    when(mockHomeViewModel.totalExpense).thenReturn('5000');
    when(mockHomeViewModel.totalIncome).thenReturn('10000');
    when(mockHomeViewModel.transaction).thenReturn([]); // or mock transactions

    // Act
    await tester.pumpWidget(
      ChangeNotifierProvider<HomeViewModel>.value(
        value: mockHomeViewModel,
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    // Assert
    expect(find.text('Hello Selva'), findsOneWidget);
    expect(find.text('Good Morning'), findsOneWidget);
    expect(find.byType(StatsCard), findsOneWidget);
    expect(find.text('Top Spendings'), findsOneWidget);
    expect(find.text('Recent Transactions'), findsOneWidget);
  });

  testWidgets('FloatingActionButton triggers showModalBottomSheet on tap',
      (WidgetTester tester) async {
    // Arrange
    when(mockHomeViewModel.status).thenReturn(3); // Success status

    // Act
    await tester.pumpWidget(
      ChangeNotifierProvider<HomeViewModel>.value(
        value: mockHomeViewModel,
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    // Tap on the FloatingActionButton
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Trigger a frame

    // Assert
    expect(find.byType(AddTransactionSheet), findsOneWidget);
  });
}
