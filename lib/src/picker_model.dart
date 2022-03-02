import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'month_item_widget.dart';

class PickerModel extends ChangeNotifier {
  static DateFormat formatter = DateFormat('MMMM yyyy');

  PickerModel({required this.selectRange, required this.validRange}) {
    selectRange = CustomDateTimeRange(start: selectRange.start, end: selectRange.end);
    if (selectRange.start != null) {
      selectRange.start = DateUtils.dateOnly(selectRange.start!);
    }

    if (selectRange.end != null) {
      selectRange.end = DateUtils.dateOnly(selectRange.end!);
    }

    if (selectRange.start != null && selectRange.end != null) {
      pageIndex = _findIndexForDay(selectRange.start!);
    } else {
      pageIndex = _findIndexForDay(DateTime.now());
    }
    pageController = PageController(initialPage: pageIndex);
  }

  int _findIndexForDay(DateTime date) {
    int retIndex = 0;
    for (int index = 0;; index++) {
      final DateTime month =
      DateUtils.addMonthsToMonthDate(DateTime(validRange.start!.year, validRange.start!.month), index);
      if (month.month == date.month && month.year == date.year) {
        retIndex = index;
        break;
      }
      if (month.isAfter(validRange.end!)) {
        break;
      }
    }
    return retIndex;
  }

  CustomDateTimeRange selectRange;
  final CustomDateTimeRange validRange;

  int pageIndex = 1;
  PageController pageController = PageController(initialPage: 0);

  String get title {
    final DateTime res = DateTime(validRange.start!.year, validRange.start!.month + pageIndex);
    return formatter.format(res);
  }

  void nextPage() {
    pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void prevPage() {
    pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void animateToPage(int index) {
    pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void updatePageIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  void updateRange(CustomDateTimeRange range) {
    var pageIndexTmp = _findIndexForDay(DateTime.now());
    animateToPage(pageIndexTmp);
    selectRange = range;
    notifyListeners();
  }

  bool get canConfirm {
    return selectRange.start != null && selectRange.end != null;
  }

  void confirm(BuildContext context) {
    if (canConfirm) {
      Navigator.of(context).maybePop(selectRange);
    }
  }

  void cancel(BuildContext context) {
    Navigator.of(context).maybePop();
  }

  void updateSelection(DateTime date) {
    if (selectRange.start != null && selectRange.end == null) {
      if (!date.isBefore(selectRange.start!)) {
        selectRange.end = date;
      } else {
        selectRange.end = selectRange.start;
        selectRange.start = date;
      }
    } else {
      selectRange.start = date;
      if (selectRange.end != null) {
        selectRange.end = null;
      }
    }
    notifyListeners();
  }
}
