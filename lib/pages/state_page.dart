import 'package:flutter/material.dart';

class StatePage extends StatefulWidget {
  const StatePage({super.key, required this.title});

  final String title;
  @override
  State<StatePage> createState() => _MyStatePage();
}

class _MyStatePage extends State<StatePage> {
  var count = 0;

  @override
  Widget build(BuildContext context) {
    void onButtonPress() {
      print('state press before $count');
      setState(() {
        count++;
      });
      print('state press after $count');
    }

    return Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.yellow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
                width: 250,
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text('count = $count',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                        )),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: FloatingActionButton(
                        onPressed: onButtonPress,
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                )),
            RawMaterialButton(
              onPressed: onButtonPress,
              fillColor: Colors.white,
              hoverColor: Colors.white,
              highlightColor: Colors.white,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.purple, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Text(
                '按钮',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ));
  }
}
