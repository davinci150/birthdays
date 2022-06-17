import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key? key}) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  int dayIndex = 0;
  int monthIndex = 0;
  int yearIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PickerItemWidget('Day', 30, DateTime.now().day),
        PickerItemWidget('Month', 12, DateTime.now().month),
        PickerItemWidget('Year', 2022, DateTime.now().year)
      ],
    );
  }
}

class PickerItemWidget extends StatefulWidget {
  const PickerItemWidget(this.title, this.count, this.initValueIndex,
      {Key? key})
      : super(key: key);
  final String title;
  final int count;
  final int initValueIndex;
  @override
  State<PickerItemWidget> createState() => _PickerItemWidgetState();
}

class _PickerItemWidgetState extends State<PickerItemWidget> {
  FixedExtentScrollController scrollController = FixedExtentScrollController();
  int ind = 0;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) {
      scrollController.animateTo((widget.initValueIndex - 1) * 40,
          duration: Duration(seconds: 1), curve: Curves.easeIn);
      ind = widget.initValueIndex;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.title),
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
