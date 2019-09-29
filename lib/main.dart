import 'package:flutter/material.dart';

void main() => runApp(Mainpage());

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  String img = "assets/images/bmrTrans.png";

  List<DropdownMenuItem<String>> listDrop = [];
  List<String> drop = ["Male", "Female"];
  String selected = 'Male';

  List<DropdownMenuItem<String>> listDrop2 = [];
  List<String> drop2 = ["Miffin -St Jeor (Default)", "Harris-Benedict"];
  String selected2 = 'Miffin -St Jeor (Default)';

  List<DropdownMenuItem<String>> listDrop3 = [];
  List<String> drop3 = [
    "Little or no exercise",
    "Sports 1-3 days per week",
    "Sports 3-5 days per week",
    "Sports 6-7 days per week",
    "Sports and a physical job"
  ];
  String selected3 = 'Little or no exercise';

  final TextEditingController _agecontroller = TextEditingController();
  final TextEditingController _hcontroller = TextEditingController();
  final TextEditingController _wcontroller = TextEditingController();
  int age = 0;
  double h = 0.0, w = 0.0, result = 0.0, result2 = 0.0;
  String bmr, calories;

  void loadData() {
    listDrop = [];
    listDrop = drop
        .map((val) => new DropdownMenuItem<String>(
              child: new Text(val),
              value: val,
            ))
        .toList();

    listDrop2 = [];
    listDrop2 = drop2
        .map((val) => new DropdownMenuItem<String>(
              child: new Text(val),
              value: val,
            ))
        .toList();

    listDrop3 = [];
    listDrop3 = drop3
        .map((val) => new DropdownMenuItem<String>(
              child: new Text(val),
              value: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return new MaterialApp(
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: new Text('BMR Application'),
        ),
        body: ListView(children: <Widget>[
          Container(
            child: Column(children: <Widget>[
              Image.asset(img, height: 150.0, fit: BoxFit.cover),
              Center(
                  child: new ListTile(
                title: Text('Gender'),
                trailing: new DropdownButtonHideUnderline(
                    child: new DropdownButton(
                        value: selected,
                        items: listDrop,
                        iconSize: 40.0,
                        elevation: 16,
                        onChanged: (value) {
                          selected = value;
                          setState(() {});
                        })),
              )),

              Center(
                  child: new ListTile(
                title: Text('BMR Equation'),
                trailing: new DropdownButtonHideUnderline(
                    child: new DropdownButton(
                        value: selected2,
                        items: listDrop2,
                        iconSize: 40.0,
                        elevation: 16,
                        onChanged: (value2) {
                          selected2 = value2;
                          setState(() {});
                        })),
              )),

              //Age
              TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    hintText: 'Please enter your age:',
                    labelText: 'Age'),
                keyboardType: TextInputType.numberWithOptions(),
                controller: _agecontroller,
              ),

              //Height
              TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    hintText: 'Please enter your Height(cm):',
                    labelText: 'Height(cm)'),
                keyboardType: TextInputType.numberWithOptions(),
                controller: _hcontroller,
              ),

              //Weight
              TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    hintText: 'Please enter your Weight(kg):',
                    labelText: 'Weight(kg):'),
                keyboardType: TextInputType.numberWithOptions(),
                controller: _wcontroller,
              ),

              Center(
                  child: new ListTile(
                title: Text('Please select your activity level:'),
              )),

              Center(
                  child: new DropdownButton(
                value: selected3,
                items: listDrop3,
                iconSize: 40.0,
                elevation: 16,
                onChanged: (value3) {
                  selected3 = value3;
                  setState(() {});
                },
              )),

              Padding(
                padding: EdgeInsets.all(5),
                child: RaisedButton(
                  child: Text("Calculate BMR"),
                  onPressed: _onPress,
                ),
              ),

              Text("Your BMR: $bmr",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              Text("Maintenance calories per day: $calories",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              Text(" "),

              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Text(
                    "Summarry: Your body will burn $bmr calories each day if you engage in no activity for that day.The estimate for maintaining your current weight (activity level) is $calories.This calculation used the $selected2 equation.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                      fontSize: 20,
                    )),
              )
            ]
                //mainAxisAlignment: MainAxisAlignment.center,
                ),
          ),
        ]),
      ),
    );
  }

  void _onPress() {
    setState(() {
      age = int.parse(_agecontroller.text);
      h = double.parse(_hcontroller.text);
      w = double.parse(_wcontroller.text);

      if (selected == "Male" && selected2 == "Harris-Benedict") {
        result = 66.47 + (13.75 * w) + (5.003 * h) - (6.755 * age);
        bmr = format(result);

        if (selected3 == "Little or no exercise") {
          result2 = result * 1.2;
          calories = format2(result2);
        } else if (selected3 == "Sports 1-3 days per week") {
          result2 = result * 1.375;
          calories = format2(result2);
        } else if (selected3 == "Sports 3-5 days per week") {
          result2 = result * 1.55;
          calories = format2(result2);
        } else if (selected3 == "Sports 6-7 days per week") {
          result2 = result * 1.725;
          calories = format2(result2);
        } else if (selected3 == "Sports and a physical job") {
          result2 = result * 1.9;
          calories = format2(result2);
        }
      } else if (selected == "Male" &&
          selected2 == "Miffin -St Jeor (Default)") {
        result = (10 * w) + (6.25 * h) - (5 * age) + 5;
        bmr = format(result);

        if (selected3 == "Little or no exercise") {
          result2 = result * 1.2;
          calories = format2(result2);
        } else if (selected3 == "Sports 1-3 days per week") {
          result2 = result * 1.375;
          calories = format2(result2);
        } else if (selected3 == "Sports 3-5 days per week") {
          result2 = result * 1.55;
          calories = format2(result2);
        } else if (selected3 == "Sports 6-7 days per week") {
          result2 = result * 1.725;
          calories = format2(result2);
        } else if (selected3 == "Sports and a physical job") {
          result2 = result * 1.9;
          calories = format2(result2);
        }
      } else if (selected == "Female" && selected2 == "Harris-Benedict") {
        result = 655.1 + (9.563 * w) + (1.85 * h) - (4.676 * age);
        bmr = format(result);

        if (selected3 == "Little or no exercise") {
          result2 = result * 1.2;
          calories = format2(result2);
        } else if (selected3 == "Sports 1-3 days per week") {
          result2 = result * 1.375;
          calories = format2(result2);
        } else if (selected3 == "Sports 3-5 days per week") {
          result2 = result * 1.55;
          calories = format2(result2);
        } else if (selected3 == "Sports 6-7 days per week") {
          result2 = result * 1.725;
          calories = format2(result2);
        } else if (selected3 == "Sports and a physical job") {
          result2 = result * 1.9;
          calories = format2(result2);
        }
      } else if (selected == "Female" &&
          selected2 == "Miffin -St Jeor (Default)") {
        result = (10 * w) + (6.25 * h) - (5 * age) - 161;
        bmr = format(result);
        if (selected3 == "Little or no exercise") {
          result2 = result * 1.2;
          calories = format2(result2);
        } else if (selected3 == "Sports 1-3 days per week") {
          result2 = result * 1.375;
          calories = format2(result2);
        } else if (selected3 == "Sports 3-5 days per week") {
          result2 = result * 1.55;
          calories = format2(result2);
        } else if (selected3 == "Sports 6-7 days per week") {
          result2 = result * 1.725;
          calories = format2(result2);
        } else if (selected3 == "Sports and a physical job") {
          result2 = result * 1.9;
          calories = format2(result2);
        }
      }
    });
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 0);
  }

  String format2(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 0);
  }
}
