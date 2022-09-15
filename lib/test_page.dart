import 'package:flutter/material.dart';

import 'presentation/colors.dart';
import 'widgets/app_bar.dart';

class TestMethod extends StatefulWidget {
  const TestMethod({
    Key? key,
  }) : super(key: key);

  @override
  State<TestMethod> createState() => _TestMethodState();
}

class _TestMethodState extends State<TestMethod> {
  final TextEditingController controller = TextEditingController();
  List<CardModel> testList = [];
  String text = '';

  void _createElement(CardModel model) {
    testList.add(model);
    setState(() {});
  }

  void _clearTitle() {
    controller.clear();
    text = ''; //controller.text
  }
  void _removeAll(){
    testList.clear();
    setState(() {});
  }
  void _removeFirst(){
    testList.removeAt(0);
    setState((){});
  }
  void _removeLast(){
    testList.removeLast();
    setState((){});
  }
  void _mixElementList(){
    testList.shuffle();
    setState((){});
  }
  void _sortByDate(){
    testList.sort((a,b)=>a.data.compareTo(b.data));
    setState((){});
  }
  void _sortByDateRevers(){
    testList.sort((a,b)=>b.data.compareTo(a.data));
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mortar,
      appBar: const CustomAppBar(
        child: Text(
          'Notes',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 27, top: 31, right: 17),
            child: Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                listButton('Remove all', onTap:_removeAll),
                listButton('Remove first', onTap:_removeFirst),
                listButton('Remove last', onTap:_removeLast),
                listButton('Mix', onTap: _mixElementList),
                listButton('Sort by date', onTap: _sortByDate),
                listButton('Sort by date reverse', onTap:_sortByDateRevers),
                listButton('Count: ${testList.length} ', onTap: (){}),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            //flex: 10,
            child: ListView.builder(
              itemCount: testList.length,
              itemBuilder: (context, index){
                return _customCard(testList[index]);
              }
                ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 27, bottom: 27, right: 27),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: _onChanged,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              iconSize: 40,
              onPressed: (){
                final name = text;
                final data =  DateTime.now();
                final model = CardModel(name,data);
                _createElement(model);
                _clearTitle();
              },
              icon: const Icon(
                Icons.add_circle_outline,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listButton(String nameButton, {required void Function() onTap} ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
        child: Text(
          nameButton,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12),
        ),
      ),
    );
  }

  Widget _customCard(CardModel model) {
    return Container(
      height: MediaQuery.of(context).size.height / 11,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(left: 33, top: 33, right: 33),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 0, 0, 0.15),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style:const  TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  model.data.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.delete_forever_outlined,
                size: 30,
                color: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onChanged(String value) {
    text = value;
  }
}

class CardModel {
  CardModel(this.name, this.data);

  final String name;
  final DateTime data;
}
