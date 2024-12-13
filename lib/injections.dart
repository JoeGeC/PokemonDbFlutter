import 'package:data/injections.dart';
import 'package:domain/domain.dart';
import 'package:presentation/presentation.dart';
import 'package:repository/injections.dart';
import 'package:local/injections.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite_common/sqlite_api.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies({Database? database}) async {
  await setupLocalDependencies(database);
  await setupDataDependencies();
  await setupRepositoryDependencies();
  await setupDomainDependencies();
  await setupPresentationInjections();
}