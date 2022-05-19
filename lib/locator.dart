import 'package:ecomappkoray/services/FirebaseAuthService.dart';
import 'package:ecomappkoray/services/FirebaseProductService.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void SetupLocator() {
  locator.registerLazySingleton(() => ProductService());
  locator.registerLazySingleton(() => FirebaseAuthService());
}
