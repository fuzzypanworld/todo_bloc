import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_bloc/isar_todo.dart';
import 'package:todo_bloc/isar_todo_repo.dart';
import 'package:todo_bloc/main.dart';
import 'package:todo_bloc/todo.dart';
import 'package:todo_bloc/todo_repo.dart';

void main() async {
  // Ensure Flutter testing is initialized
  TestWidgetsFlutterBinding.ensureInitialized();

  // Set up Isar for testing
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);
  final isarTodoRepo = IsarTodoRepo(isar);

  // Run the widget tests
  testWidgets('Adding a todo item test', (WidgetTester tester) async {
    // Build the app and provide the real repository
    await tester.pumpWidget(MyApp(todoRepo: isarTodoRepo));

    // Enter a new todo item into the text field
    await tester.enterText(find.byType(TextField), 'New Todo');

    // Tap the button to add the new todo
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // Trigger a rebuild

    // Now, get the list of todos to verify
    final todos = await isarTodoRepo.getTodos();
    expect(todos, isNotEmpty); // Check that there's at least one todo

    // Verify that the new todo appears in the list
    expect(find.text('New Todo'), findsOneWidget);
  });
}
