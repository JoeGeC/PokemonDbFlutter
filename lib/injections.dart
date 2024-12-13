import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:presentation/presentation.dart';
import 'package:repository/repository.dart';
import 'package:local/local.dart';
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