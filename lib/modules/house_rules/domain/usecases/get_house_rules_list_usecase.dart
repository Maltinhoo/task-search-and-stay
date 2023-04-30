import 'package:dartz/dartz.dart';

import '../entities/house_rule_entity.dart';
import '../repositories/house_rules_repository.dart';

abstract class GetHouseRulesListUseCase {
  Future<Either<Exception, List<HouseRuleEntity>>> call(int page);
}

class GetHouseRulesListUseCaseImpl implements GetHouseRulesListUseCase {
  final IHouseRuleRepository repository;

  GetHouseRulesListUseCaseImpl(this.repository);

  @override
  Future<Either<Exception, List<HouseRuleEntity>>> call(int page) async {
    return await repository.getAllHouseRules(page);
  }
}
