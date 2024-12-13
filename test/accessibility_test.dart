import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_db/src/injections.dart';
import 'package:pokemon_db/main.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'mocks/mock_database.dart';

void main() {
  late Database database;
  late MockDatabase mockDatabase;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockDatabase = MockDatabase(database);
    await mockDatabase.setupMockPokemonTable();
    await mockDatabase.setupMockPokedexEntryNumbersTable();
    await mockDatabase.setupMockPokedexTable();
  });

  tearDown(() async {
    await database.close();
  });

  testWidgets('Follows a11y guidelines', (tester) async {
    await setupDependencies(database: database);

    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(const MyApp());

    // Checks that tappable nodes have a minimum size of 48 by 48 pixels
    // for Android.
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));

    // Checks that tappable nodes have a minimum size of 44 by 44 pixels
    // for iOS.
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));

    // Checks that touch targets with a tap or long press action are labeled.
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    // Checks whether semantic nodes meet the minimum text contrast levels.
    // The recommended text contrast is 3:1 for larger text
    // (18 point and above regular).
    await expectLater(tester, meetsGuideline(textContrastGuideline));

    await tester.pumpAndSettle();
    handle.dispose();

  });
}