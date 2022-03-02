import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telgani_partners/util/extension/build_context_extension.dart';

import 'picker_model.dart';

class PickerBottom extends StatelessWidget {
  const PickerBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PickerModel vm = Provider.of<PickerModel>(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 12, bottom: 12, right: 12),
      child: Opacity(
        opacity: vm.canConfirm ? 1.0 : 0.6,
        child: ElevatedButton(
          onPressed: () => vm.confirm(context),
          child: Text(
            context.strings.global.done,
          ),
        ),
      ),
    );
  }
}
