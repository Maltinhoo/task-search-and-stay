import 'package:dartz/dartz.dart';

import '../repositories/house_rules_repository.dart';

abstract class DeleteHouseRuleUseCase {
  Future<Either<Exception, String>> call(int id);
}

class DeleteHouseRuleUseCaseImpl implements DeleteHouseRuleUseCase {
  final IHouseRuleRepository repository;

  DeleteHouseRuleUseCaseImpl(this.repository);

  @override
  Future<Either<Exception, String>> call(int id) async {
    return await repository.deleteHouseRule(id);
  }
}
