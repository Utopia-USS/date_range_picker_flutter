import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'flexible.dart';
import 'month_item_widget.dart';
import 'picker_bottom.dart';
import 'picker_header.dart';
import 'picker_main.dart';
import 'picker_model.dart';

class DataRangePicker extends StatefulWidget {
  DataRangePicker({Key? key, required this.selectRange, required this.validRange}) : super(key: key);

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
                  )),
        ],
        child: OrientationBuilder(
          builder: (context, orientation) {
            XFlexible.registerWidth(MediaQuery.of(context).size.width);
            return Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.w), topRight: Radius.circular(10.w)),
                  child: Consumer<PickerModel>(
                    builder: (context, vm, child) {
                      return SafeArea(
                        top: false,
                        bottom: true,
                        child: Container(
                          // width: 374.w,
                          width: double.infinity,
                          height: 436.w + 40.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.w), topRight: Radius.circular(10.w)),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                  child: PickerMainContent(
                                model: vm,
                              )),
                              PickerBottom(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ));
  }
}

Future<CustomDateTimeRange?> showTCRDateRangePicker({
  required BuildContext context,
  required CustomDateTimeRange selectRange,
  required CustomDateTimeRange validRange,
  bool useRootNavigator = true,
}) {
  return showDialog<CustomDateTimeRange?>(
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
