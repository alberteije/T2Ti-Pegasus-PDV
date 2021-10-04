import 'package:get_it/get_it.dart';

import 'package:fenix/src/service/cadastros/pessoa_service.dart';
import 'package:fenix/src/view_model/cadastros/pessoa_view_model.dart';
import 'package:fenix/src/service/cadastros/banco_service.dart';
import 'package:fenix/src/view_model/cadastros/banco_view_model.dart';
import 'package:fenix/src/service/cadastros/banco_agencia_service.dart';
import 'package:fenix/src/view_model/cadastros/banco_agencia_view_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => BancoService());
  locator.registerLazySingleton(() => BancoAgenciaService());
  locator.registerLazySingleton(() => PessoaService());

  locator.registerFactory(() => BancoViewModel());
  locator.registerFactory(() => BancoAgenciaViewModel());
  locator.registerFactory(() => PessoaViewModel());
}