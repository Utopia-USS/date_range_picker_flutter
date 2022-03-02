import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'month_item_widget.dart';
import 'picker_bottom.dart';
import 'picker_main.dart';
import 'picker_model.dart';

class DataRangePicker extends StatefulWidget {
  const DataRangePicker({Key? key, required this.selectRange, required this.validRange}) : super(key: key);

  final CustomDateTimeRange selectRange;
  final CustomDateTimeRange validRange;

  @override
  _DataRangePickerState createState() => _DataRangePickerState();
}

class _DataRangePickerState extends State<DataRangePicker> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PickerModel>(
          create: (context) => PickerModel(
            selectRange: widget.selectRange,
            validRange: widget.validRange,
          ),
        ),
      ],
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          color: Colors.white,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Consumer<PickerModel>(
            builder: (context, vm, child) {
              return SafeArea(
                top: false,
                bottom: true,
                child: Container(
                  width: double.infinity,
                  height: 420,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: PickerMainContent(
                          model: vm,
                        ),
                      ),
                      const PickerBottom(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<CustomDateTimeRange?> showTCRDateRangePicker({
  required BuildContext context,
  required CustomDateTimeRange selectRange,
  required CustomDateTimeRange validRange,
  bool useRootNavigator = true,
}) {
  return showDialog<CustomDateTimeRange>(
    context: context,
    useRootNavigator: useRootNavigator,
    useSafeArea: false,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (BuildContext context) {
      return DataRangePicker(
        selectRange: selectRange,
        validRange: validRange,
      );
    },
  );
}
