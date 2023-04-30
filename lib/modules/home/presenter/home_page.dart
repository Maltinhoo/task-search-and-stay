import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:search_and_stay_challenge/modules/home/presenter/cubit/home_cubit.dart';
import 'package:search_and_stay_challenge/modules/home/presenter/widgets/add_house_rule.dart';
import 'package:search_and_stay_challenge/modules/home/presenter/widgets/create_rule.dart';
import 'package:search_and_stay_challenge/modules/home/presenter/widgets/house_rule_card.dart';
import 'package:search_and_stay_challenge/modules/home/presenter/widgets/house_rule_dialog.dart';
import 'package:search_and_stay_challenge/modules/house_rules/infra/model/house_rule_model.dart';

import '../../../core/inject/inject.dart';
import '../../house_rules/domain/entities/house_rule_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PagingController<int, HouseRuleEntity> _pagingController =
      PagingController(firstPageKey: 10);
  double scrollOffset = 0;

  late ScrollController scrollController;
  _scrollListener() {
    setState(() {
      scrollOffset = scrollController.offset;
    });
  }

  final homeCubit = getIt<HomeCubit>();
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      try {
        await homeCubit.getHouseRules((pageKey / 10).floor());
        final isLastPage =
            (homeCubit.state as HomeLoaded).houseRules.length < 10;

        if (isLastPage) {
          _pagingController
              .appendLastPage((homeCubit.state as HomeLoaded).houseRules);
        } else {
          final nextPageKey = pageKey + 10;
          _pagingController.appendPage(
              (homeCubit.state as HomeLoaded).houseRules, nextPageKey);
        }
      } catch (error) {
        _pagingController.error = error;
      }
    });

    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    _pagingController.notifyPageRequestListeners(10);
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: BlocProvider<HomeCubit>.value(
            value: homeCubit,
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return BlocListener<HomeCubit, HomeState>(
                  listener: (context, state) {
                    if (state is HomeError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                    if (state is HomeDeleteHouseRule) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.message),
                        ),
                      );
                    }
                    if (state is HomeCreateNewHouseRule) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(state.message),
                        ),
                      );
                    }
                    if (state is HomeUpdateHouseRule) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }

                    if (state is HomeGetHouseRule) {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              HouseRuleDialog(rule: state.houseRuleEntity));
                    }
                  },
                  child: PagedListView(
                    pagingController: _pagingController,
                    scrollController: scrollController,
                    padding: const EdgeInsets.only(bottom: 50),
                    physics: const BouncingScrollPhysics(),
                    builderDelegate: PagedChildBuilderDelegate<HouseRuleEntity>(
                      itemBuilder: (context, item, index) => HouseRuleCard(
                        rule: item,
                        delete: (context) async {
                          await homeCubit.deleteHouseRule(item.id ?? 0);
                          _pagingController.refresh();
                        },
                        edit: (context) async {
                          await showModalBottomSheet(
                              context: context,
                              builder: (context) => FormRule(
                                    isEditing: true,
                                    rule: item as HouseRuleModel,
                                    onPressed: (name, active) async {
                                      await homeCubit
                                          .updateHouseRule(HouseRuleModel(
                                        id: item.id,
                                        name: name,
                                        active: active,
                                      ));
                                      _pagingController.refresh();
                                    },
                                  ));
                        },
                        onLongPress: () => homeCubit.getHouseRule(item.id ?? 0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          floatingActionButton: AddHouseRule(
            onPressed: (name, active) async {
              await homeCubit.addNewHouseRule(HouseRuleModel(
                name: name,
                active: active,
              ));
              _pagingController.refresh();
            },
          )),
    );
  }
}
