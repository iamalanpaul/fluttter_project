import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MaterialApp(
  home: calculator(),
));

class calculator extends StatefulWidget {
  @override
  _calculatorState createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  String exp = '0';
  String result = '0';
  String expression = '';

  Function buttonpressed(String text){
    setState(() {
      if(text == 'c'){
        exp = '0';
        result = '0';
      }
      else if(text == 'x'){
        exp = exp.substring(0 , exp.length - 1);
        if(exp == ''){
          exp = '0';
        }
      }
      else if(text == '='){
        expression = exp;
        try{
          Parser p = new Parser();
          Expression x = p.parse(expression);
          ContextModel c = new ContextModel();
          result = '${x.evaluate(EvaluationType.REAL, c)}';

        }
        catch(e){
          result = 'ERROR!!';
        }
      }
      else{
        if(exp == '0' ){
          exp = text;
        }
        else{
          exp = exp + text;
        }
      }
    });
  }

  Widget CreateButton( String text, Color bcolor, double bhieght){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * bhieght,
      color: bcolor,
      //  padding: EdgeInsets.all(16.0),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.black,
            width: 1,
            style: BorderStyle.solid
          )
        ),
        onPressed: () => buttonpressed(text),
        padding: EdgeInsets.all(10.0),
        child: Text(text,style: TextStyle(
            fontSize: 30.0,
            color: Colors.white
        ),),

      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(

            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
            child: Text(exp,style: TextStyle(
                fontSize: 20,
                color: Colors.black
            ),),
          ),
          Container(

            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
            child: Text(result,style: TextStyle(
                fontSize: 20,
                color: Colors.black
            ),),
          ),

          Expanded(child: Divider()),

          Row(
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        CreateButton('c', Colors.red, 1),
                        CreateButton('x', Colors.blue, 1),
                        CreateButton('/', Colors.blue, 1),
                      ]
                    ),

                    TableRow(
                        children: [
                          CreateButton('7', Colors.grey[500], 1),
                          CreateButton('8', Colors.grey[500], 1),
                          CreateButton('9', Colors.grey[500], 1),
                        ]
                    ),

                    TableRow(
                        children: [
                          CreateButton('4', Colors.grey[500], 1),
                          CreateButton('5', Colors.grey[500], 1),
                          CreateButton('6', Colors.grey[500], 1),
                        ]
                    ),

                    TableRow(
                        children: [
                          CreateButton('1', Colors.grey[500], 1),
                          CreateButton('2', Colors.grey[500], 1),
                          CreateButton('3', Colors.grey[500], 1),
                        ]
                    ),

                    TableRow(
                        children: [
                          CreateButton(' ', Colors.grey[500], 1),
                          CreateButton('0', Colors.grey[500], 1),
                          CreateButton('.', Colors.grey[500], 1),
                        ]
                    ),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        CreateButton('*', Colors.blue, 1)
                      ]
                    ),
                    TableRow(
                        children: [
                          CreateButton('%', Colors.blue, 1)
                        ]
                    ),

                    TableRow(
                        children: [
                          CreateButton('+', Colors.blue, 1)
                        ]
                    ),

                    TableRow(
                        children: [
                          CreateButton('-', Colors.blue, 1)
                        ]
                    ),

                    TableRow(
                        children: [
                          CreateButton('=', Colors.red, 1)
                        ]
                    ),
                  ],

                ),

              )
            ],
          )


        ],
      ),
    );
  }
}
