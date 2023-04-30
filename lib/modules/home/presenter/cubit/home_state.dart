part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoadingMore extends HomeState {}

class HomeLoaded extends HomeState {
  final List<HouseRuleEntity> houseRules;

  HomeLoaded(this.houseRules);
}

class HomeCreateNewHouseRule extends HomeState {
  final String message;

  HomeCreateNewHouseRule(this.message);
}

class HomeDeleteHouseRule extends HomeState {
  final String message;

  HomeDeleteHouseRule(this.message);
}

class HomeUpdateHouseRule extends HomeState {
  final String message;

  HomeUpdateHouseRule(this.message);
}

class HomeGetHouseRule extends HomeState {
  final HouseRuleEntity houseRuleEntity;

  HomeGetHouseRule(this.houseRuleEntity);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
