import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double x = 0.0;
  double y = 0.0;
  Offset of1 = Offset(0, 0);
  Offset of2 = Offset(0, 0);
  double value = 0;
  double time = 0.001;



  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });

  }

  void calculate(PointerEvent details) {
    setState(() {
      double distance = sqrt(pow((of1.dy - of2.dy), 2) + pow((of1.dx - of2.dx), 2));
      double speed = distance / time;
      value = speed;
      of2 = of1;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: MouseRegion(
            onHover: (e){
              _updateLocation(e);
              calculate(e);
            },
            child: Row(
              children: [
                Expanded(
                    child: Column(
                      children: [
                        Expanded(child: buildCustomMeterWidget('x position',1601,x)),
                      ],
                    )
                ),
                Expanded(
                    child: Column(
                      children: [
                        Expanded(child: buildCustomMeterWidget('y position', 800,y)),
                      ],
                    )
                ),
                Expanded(
                    child: Column(
                      children: [
                        Expanded(child: buildCustomMeterWidget('speed', 500,value)),
                      ],
                    )
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCustomMeterWidget(String text,double distance,double value){
    return Stack(
      children: [
        Positioned(
          top: 20,left: 20,
          child: Text(text),),
        Positioned(
          top: 65,bottom: 0,right:-60,
          child: Container(
          width: 400,
          height: 400,
          child: SfRadialGauge(
            axes: [
              RadialAxis(
                axisLabelStyle: GaugeTextStyle(
                    color: Colors.black
                ),
                startAngle: 170,
                endAngle: -60,
                interval: 100,
                minimum: 0,
                maximum: distance,
                pointers: [
                  NeedlePointer(
                    onValueChanged: (e){
                      setState(()=>value=e);
                    },
                    value: value,
                    needleColor: Colors.red,
                    needleLength: 30,
                    needleEndWidth: 2,
                    needleStartWidth: 2,
                    enableAnimation: true,
                  )
                ],

              ),
            ],

          ),
        ),),
      ],
    );
  }
}
