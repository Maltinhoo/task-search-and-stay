import 'package:get_it/get_it.dart';
import 'package:search_and_stay_challenge/modules/house_rules/domain/usecases/create_new_house_rule_usecase.dart';

import '../../modules/home/presenter/cubit/home_cubit.dart';
import '../../modules/house_rules/domain/repositories/house_rules_repository.dart';
import '../../modules/house_rules/domain/usecases/delete_house_rule_usecase.dart';
import '../../modules/house_rules/domain/usecases/get_house_rule_usecase.dart';
import '../../modules/house_rules/domain/usecases/get_house_rules_list_usecase.dart';
import '../../modules/house_rules/domain/usecases/update_house_rule_usecase.dart';
import '../../modules/house_rules/external/remote/house_rule_http_datasource_imp.dart';
import '../../modules/house_rules/infra/datasource/house_rule_external_datasource.dart';
import '../../modules/house_rules/infra/repositories/house_rule_repository.dart';

GetIt getIt = GetIt.I;

class Inject {
  static void init() {
    getIt.registerFactory<IHouseRuleExternalDatasource>(
        () => HouseRuleHttpDatasourceImpl());

    getIt.registerFactory<IHouseRuleRepository>(
        () => HouseRuleRepository(getIt()));

    getIt.registerFactory<CreateNewHouseRuleUseCase>(
        () => CreateNewHouseRuleUseCaseImpl(getIt()));
    getIt.registerFactory<DeleteHouseRuleUseCase>(
        () => DeleteHouseRuleUseCaseImpl(getIt()));
    getIt.registerFactory<UpdateHouseRuleUseCase>(
        () => UpdateHouseRuleUseCaseImpl(getIt()));
    getIt.registerFactory<GetHouseRuleUseCase>(
        () => GetHouseRuleUseCaseImpl(getIt()));
    getIt.registerFactory<GetHouseRulesListUseCase>(
        () => GetHouseRulesListUseCaseImpl(getIt()));

    getIt.registerFactory<HomeCubit>(() => HomeCubit(
          getIt(),
          getIt(),
          getIt(),
          getIt(),
          getIt(),
        ));
  }
}
