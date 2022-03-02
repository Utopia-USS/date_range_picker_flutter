import 'package:flutter/material.dart';
import 'package:telgani_partners/common/constants/app_font.dart';

import 'month_item_widget.dart';
import 'picker_model.dart';

class PickerMainContent extends StatefulWidget {
  final PickerModel model;

  const PickerMainContent({Key? key, required this.model}) : super(key: key);

  @override
  _PickerMainContentState createState() => _PickerMainContentState();
}

class _PickerMainContentState extends State<PickerMainContent> {
  @override
  Widget build(BuildContext context) {
    final PickerModel vm = widget.model;
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          _ContentHeader(
            title: vm.title,
            leftCallback: vm.prevPage,
            rightCallback: vm.nextPage,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.transparent,
              child: PageView.builder(
                controller: vm.pageController,
                itemBuilder: (BuildContext context, int index) {
                  final DateTime month = DateUtils.addMonthsToMonthDate(
                      DateTime(vm.validRange.start!.year, vm.validRange.start!.month), index);
                  return Container(
                    color: Colors.white,
                    child: MonthItemWidget(
                      displayedMonth: month,
                      range: vm.selectRange,
                      firstDate: vm.validRange.start!,
                      lastDate: vm.validRange.end!,
                      changedCallback: vm.updateSelection,
                    ),
                  );
                },
                onPageChanged: vm.updatePageIndex,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ContentHeader extends StatelessWidget {
  final String title;
  final VoidCallback? leftCallback;
  final VoidCallback? rightCallback;

  const _ContentHeader({this.title = '', this.leftCallback, this.rightCallback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ArrowBtn(
            callback: leftCallback,
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              fontSize: 20,
              fontFamily: AppFont.hanimationArabic,
              letterSpacing: 0.5,
            ),
          ),
          _ArrowBtn(
            isLeft: false,
            callback: rightCallback,
          ),
        ],
      ),
    );
  }
}

class _ArrowBtn extends StatelessWidget {
  final VoidCallback? callback;
  final bool isLeft;

  const _ArrowBtn({this.callback, this.isLeft = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.all(16),
        width: 30,
        height: 30,
        color: Colors.transparent,
        child: Icon(
          isLeft ? Icons.arrow_back_ios_rounded : Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}
