import 'package:flutter/material.dart';
import 'package:search_and_stay_challenge/modules/home/presenter/widgets/create_rule.dart';

class AddHouseRule extends StatelessWidget {
  final Function(String name, int active) onPressed;
  const AddHouseRule({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => FormRule(onPressed: onPressed));
      },
      child: const Icon(Icons.add),
    );
  }
}
