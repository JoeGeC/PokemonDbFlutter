import 'package:data/injections.dart';
import 'package:domain/injections.dart';
import 'package:presentation/injections.dart';
import 'package:repository/injections.dart';
import 'package:local/injections.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  await setupLocalDependencies();
  await setupDataDependencies();
  await setupRepositoryDependencies();
  await setupDomainDependencies();
  await setupPresentationInjections();
}