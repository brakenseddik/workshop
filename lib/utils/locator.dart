import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:untitled/features/auth/data/sources/auth_local_datasource.dart';
import 'package:untitled/features/auth/data/sources/auth_remote_datasource.dart';
import 'package:untitled/features/auth/domain/repositories/auth_repository.dart';
import 'package:untitled/features/auth/domain/use_cases/auth_usecases.dart';
import 'package:untitled/utils/services/api_service.dart';
import 'package:untitled/utils/services/localdb_service.dart';

final GetIt locator = GetIt.instance;

setup() async {
  final instance = await SharedPreferences.getInstance();
  // Register services
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => LocalDbService(instance));
  // Register Blocs
  // Register usecases
  locator.registerLazySingleton<AuthUseCases>(
      () => AuthUseCases(locator<IAuthRepository>()));
  // Register Repositories
  locator.registerLazySingleton<IAuthRepository>(() => AuthRepository(
      locator<AuthRemoteDataSource>(), locator<AuthLocalDataSource>()));
// register DataSources
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(locator()));

  locator.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(locator<LocalDbService>()));
}
