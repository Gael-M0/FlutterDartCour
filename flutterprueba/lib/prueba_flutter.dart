import 'package:flutter/material.dart';

class prueba_flutter extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba Flutter'),
      ),
      body: Stack(
        children: <Widget>[

          Container(
            color: Colors.blueAccent,

          ),

          Container(

            height: 300,
            width: 300,
            color: Colors.red,
          ),

          Container(
            height: 100,
            width: 100,
            color: Colors.black,
          )

        ],
      ),
    );
  }
}