import 'package:flutter/material.dart';
import 'package:search_and_stay_challenge/modules/house_rules/infra/model/house_rule_model.dart';

class FormRule extends StatefulWidget {
  final Function(String name, int active) onPressed;
  final bool isEditing;
  final HouseRuleModel? rule;
  const FormRule(
      {super.key, required this.onPressed, this.isEditing = false, this.rule});

  @override
  State<FormRule> createState() => _FormRuleState();
}

class _FormRuleState extends State<FormRule> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _isActiveController = TextEditingController();

  bool _isActive = false;

  @override
  void initState() {
    if (widget.isEditing) {
      _nameController.text = widget.rule!.name;
      _isActive = widget.rule!.active == 1 ? true : false;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _isActiveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              onChanged: (value) {
                if (value.isEmpty) {
                  return;
                }
              },
              decoration: InputDecoration(
                hintText: widget.rule?.name ?? 'Nome da regra',
                label: widget.rule?.name != null
                    ? null
                    : const Text('Nome da regra'),
              ),
            ),
            Row(
              children: [
                const Text('A regra está ativa?',
                    style: TextStyle(fontSize: 18)),
                Switch.adaptive(
                  value: _isActive,
                  onChanged: (value) {
                    _isActive = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_isActive == true) {
                  _isActiveController.text = '1';
                } else {
                  _isActiveController.text = '0';
                }
                widget.onPressed(
                    _nameController.text, int.parse(_isActiveController.text));
                Navigator.pop(context);
              },
              child: Text(widget.isEditing ? 'Editar' : 'Criar'),
            )
          ],
        ),
      ),
    );
  }
}
