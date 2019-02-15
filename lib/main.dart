import 'package:flutter/material.dart';
import 'dart:math';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _numSliderValue = 120.0;
  var _factorSliderValue = 15.0;

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context,constraints){
      return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
              child: Column(
                children: <Widget>[
                  Slider(value: _numSliderValue, min : 100.0,max: 1500.0,onChanged: (value){
                    setState(() {
                      this._numSliderValue = value;
                    });
                  }),
                  Slider(value: _factorSliderValue, min : 2.0,max: 20.0,onChanged: (value){
                    setState(() {
                      this._factorSliderValue = value;
                    });
                  }),

                  Container(
                    margin: EdgeInsets.only(top: constraints.maxHeight/4),
                    child:                   CustomPaint(
                      painter: MyPaint(_numSliderValue.toInt(),
                          _factorSliderValue,
                          constraints.maxHeight),
                      isComplex: true,
                      willChange: true,
                    ),

                  )
                  ,
                ],
              )
          )

      );
    });
  }
}

class MyPaint extends CustomPainter {
  double radius;
  final int numPoint;
  final double factor;
  final double s;

  MyPaint(this.numPoint, this.factor,this.s);


  @override
  void paint(Canvas canvas, Size size) {
    radius = s/4;
    var paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 0.5;

    var points = List<Point>();

    //draw points
    for (int i = 0; i < numPoint; i++) {
      var angle = ((pi * factor) / numPoint) * (i);
      var x = radius * cos(angle);
      var y = radius * sin(angle);
      points.add(Point(x: x, y: y));
    }

    for (int i = 0; i < points.length; i++) {
      canvas.drawLine(Offset(points[i].x, points[i].y),
          Offset(points[(i * factor).toInt() % points.length].x,
              points[(i * factor).toInt() % points.length].y), paint);
    }


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Point{
  final double x;
  final double y;
  Point({this.x,this.y});
}
