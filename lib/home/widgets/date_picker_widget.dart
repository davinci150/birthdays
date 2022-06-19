import 'package:birthdays/presentation/colors.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key? key, required this.onDateTimeChanged})
      : super(key: key);
  final void Function(DateTime) onDateTimeChanged;
  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  int dayIndex = DateTime.now().day;
  int monthIndex = DateTime.now().month;
  int yearIndex = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PickerItemWidget(
            title: 'Day',
            onChangeValue: (value) {
              dayIndex = value + 1;
              widget
                  .onDateTimeChanged(DateTime(yearIndex, monthIndex, dayIndex));
              setState(() {});
            },
            count: 30,
            initValueIndex: dayIndex),
        PickerItemWidget(
            title: 'Month',
            onChangeValue: (value) {
              monthIndex = value + 1;
              widget
                  .onDateTimeChanged(DateTime(yearIndex, monthIndex, dayIndex));
              setState(() {});
            },
            count: 12,
            initValueIndex: monthIndex),
        PickerItemWidget(
            title: 'Year',
            onChangeValue: (value) {
              yearIndex = value + 1;
              widget
                  .onDateTimeChanged(DateTime(yearIndex, monthIndex, dayIndex));
              setState(() {});
            },
            count: 2022,
            initValueIndex: yearIndex)
      ],
    );
  }
}

class PickerItemWidget extends StatefulWidget {
  const PickerItemWidget({
    required this.title,
    required this.onChangeValue,
    required this.count,
    required this.initValueIndex,
    Key? key,
  }) : super(key: key);
  final String title;
  final int count;
  final int initValueIndex;
  final void Function(int) onChangeValue;
  @override
  State<PickerItemWidget> createState() => _PickerItemWidgetState();
}

class _PickerItemWidgetState extends State<PickerItemWidget> {
  FixedExtentScrollController scrollController = FixedExtentScrollController();
  int ind = 0;

  @override
  void initState() {
    Future<dynamic>.delayed(const Duration(seconds: 0)).then((dynamic value) {
      scrollController.animateTo((widget.initValueIndex - 1) * 40,
          duration: const Duration(seconds: 1), curve: Curves.easeIn);
      ind = widget.initValueIndex;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.lightGray),
        ),
        const SizedBox(
          height: 12,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 100,
               width: 100,
              child: ListWheelScrollView.useDelegate(
                controller: scrollController,
                physics: const FixedExtentScrollPhysics(),
                itemExtent: 40,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    ind = index;
                    widget.onChangeValue(ind);
                  });
                },
                childDelegate: ListWheelChildBuilderDelegate(
                    childCount: widget.count,
                    builder: (BuildContext context, int index) {
                      return Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 30,
                          color: ind == index ? Colors.black : Colors.grey,
                          //color: Colors.grey,
                        ),
                      );
                    }),
              ),
            ),
            //  IgnorePointer(
            //    child: Container(
            //      color: Colors.black.withOpacity(0.1),
            //      height: 40,
            //      width: 100,
            //    ),
            //  )
            //ColorFiltered(
            //  child: Container(
            //    //color: Colors.transparent,
            //    width: 100,
            //    height: 40,
            //  ),
            //  colorFilter: ColorFilter.mode(Colors.black, BlendMode.clear),
            //)
          ],
        ),
      ],
    );
  }
}
