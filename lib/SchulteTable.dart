//Yavuz Selim GÜLER
//1306160016
import 'package:flutter/material.dart';
import 'dart:math';
import 'box.dart';
import 'endScreen.dart';
import 'TimerText.dart';

class SchulteTable extends StatefulWidget {
  @override
  _SchulteTableState createState() => _SchulteTableState();
}

class _SchulteTableState extends State<SchulteTable> {
  Stopwatch stopwatch = new Stopwatch();

  List<Box> boxesList;
  var numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25];
  var k = 1;
  Duration bestScore;

  @override
  void initState() {
    super.initState();
    boxesList = doInit();
    stopwatch.start();
  }

  List<Box> doInit() {
    //Karıştırıcı
    var random = new Random();
    for (var i = numbers.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = numbers[i];
      numbers[i] = numbers[n];
      numbers[n] = temp;
    }

    var boxes = <Box>[
      new Box(id: 0, text: numbers[0].toString()),
      new Box(id: 1, text: numbers[1].toString()),
      new Box(id: 2, text: numbers[2].toString()),
      new Box(id: 3, text: numbers[3].toString()),
      new Box(id: 4, text: numbers[4].toString()),
      new Box(id: 5, text: numbers[5].toString()),
      new Box(id: 6, text: numbers[6].toString()),
      new Box(id: 7, text: numbers[7].toString()),
      new Box(id: 8, text: numbers[8].toString()),
      new Box(id: 9, text: numbers[9].toString()),
      new Box(id: 10, text: numbers[10].toString()),
      new Box(id: 11, text: numbers[11].toString()),
      new Box(id: 12, text: numbers[12].toString()),
      new Box(id: 13, text: numbers[13].toString()),
      new Box(id: 14, text: numbers[14].toString()),
      new Box(id: 15, text: numbers[15].toString()),
      new Box(id: 16, text: numbers[16].toString()),
      new Box(id: 17, text: numbers[17].toString()),
      new Box(id: 18, text: numbers[18].toString()),
      new Box(id: 19, text: numbers[19].toString()),
      new Box(id: 20, text: numbers[20].toString()),
      new Box(id: 21, text: numbers[21].toString()),
      new Box(id: 22, text: numbers[22].toString()),
      new Box(id: 23, text: numbers[23].toString()),
      new Box(id: 24, text: numbers[24].toString()),
    ];
    return boxes;
  }

  //Tuş basım sırasının kontrolü
  void playGame(Box b) {
    setState(() {
      if (int.parse(b.text) == k) {
        b.bg = Colors.green;
        b.inactive = false;
        k++;
        if (k == 26) {
          finishGame();
        }
      }
    });
  }

  //Oyun sonu
  void finishGame() {
    int hiScore = bestScoreFunc(stopwatch.elapsed);
    stopwatch.stop();

    if (hiScore == 1) {
      showDialog(
          context: context,
          builder: (_) => new EndScreen(
              "High Score!!", "Press reset button to start again.", resetGame));
    } else {
      showDialog(
          context: context,
          builder: (_) => new EndScreen("Game Completed",
              "Press reset button to start again.", resetGame));
    }
  }

  //Yeniden başlatma
  void resetGame() {
    k = 1;
    stopwatch.reset();
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      boxesList = doInit();
    });
    stopwatch.start();
  }

  //Yüksek skor hesaplama
  int bestScoreFunc(Duration currentScore) {
    if (bestScore == null || bestScore > currentScore) {
      bestScore = currentScore;
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Schulte Table",
        style: TextStyle(color: Colors.white),
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //kutular
          Expanded(
            child: new GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: boxesList.length,
              itemBuilder: (context, i) => SizedBox(
                width: 50,
                height: 50,
                child: RaisedButton(
                  padding: EdgeInsets.all(8),
                  onPressed: boxesList[i].inactive ? () => playGame(boxesList[i]):null,
                  child: Text(
                    boxesList[i].text,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: boxesList[i].bg,
                  disabledColor: boxesList[i].bg,
                ),
              ),
            ),
          ),

          //Zamanlayıcı
          Container(
            height: 50,
            child: new Center(child: new TimerText(stopwatch: stopwatch))),

          //Yüksek Skor
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Center(
              child: Text(
                'Best Score:' + bestScore.toString(),
                style: TextStyle(fontSize: 20),
            )),
          ),

          //Reset Butonu
            RaisedButton(
              child: Text('Reset',
                style: TextStyle(color: Colors.white, fontSize: 20)),
                color: Colors.orange,
                padding: EdgeInsets.all(20),
                onPressed: resetGame,
            ),
        ],
      ),
    );
  }
}