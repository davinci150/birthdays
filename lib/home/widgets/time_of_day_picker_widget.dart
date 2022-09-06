import 'package:flutter/material.dart';

import '../../presentation/colors.dart';

class TimeOfDayPicker extends StatefulWidget {
  const TimeOfDayPicker({
    Key? key,
    required this.onDateTimeChanged,
    this.initDate,
  }) : super(key: key);

  final void Function(TimeOfDay) onDateTimeChanged;
  final TimeOfDay? initDate;

  @override
  State<TimeOfDayPicker> createState() => _TimeOfDayPickerState();
}

class _TimeOfDayPickerState extends State<TimeOfDayPicker> {
  late int hours;
  late int minutes;

  @override
  void initState() {
    final TimeOfDay startDate = widget.initDate ?? TimeOfDay.now();
    hours = startDate.hour;
    minutes = startDate.minute;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TimeItemWidget(
            title: 'Hours',
            onChangeValue: (value) {
              hours = value;
              widget.onDateTimeChanged(TimeOfDay(hour: hours, minute: minutes));
              setState(() {});
            },
            max: 23,
            initValueIndex: hours),
        const Padding(
          padding: EdgeInsets.only(top: 26),
          child: Text(
            ':',
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        ),
        TimeItemWidget(
            title: 'Minutes',
            onChangeValue: (value) {
              minutes = value;
              widget.onDateTimeChanged(TimeOfDay(hour: hours, minute: minutes));
              setState(() {});
            },
            max: 59,
            initValueIndex: minutes),
      ],
    );
  }
}

class TimeItemWidget extends StatefulWidget {
  const TimeItemWidget({
    required this.title,
    required this.onChangeValue,
    required this.max,
    this.min,
    required this.initValueIndex,
    this.isShowName = false,
    this.isShowZero = false,
    Key? key,
  }) : super(key: key);

  final bool isShowZero;
  final bool isShowName;
  final String title;
  final int? min;
  final int max;
  final int initValueIndex;
  final void Function(int) onChangeValue;

  @override
  State<TimeItemWidget> createState() => _TimeItemWidgetState();
}

class _TimeItemWidgetState extends State<TimeItemWidget> {
  FixedExtentScrollController scrollController = FixedExtentScrollController();
  int ind = 0;

  @override
  void initState() {
    Future<dynamic>.delayed(const Duration(seconds: 0)).then((dynamic value) {
      scrollController.animateToItem(widget.initValueIndex,
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
                    childCount: widget.max + 1,
                    builder: (BuildContext context, int index) {
                      return Text(
                        index < 10 ? '0$index' : '$index',
                        style: TextStyle(
                          fontSize: 30,
                          color: ind == index ? Colors.black : Colors.grey,
                          //color: Colors.grey,
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}



