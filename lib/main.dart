import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Number Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey[100],
      ),
      home: homepage(),
    );
  }
}

class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _URL = 'assets/images/1.jpg';
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(_URL),
        fit: BoxFit.cover,
      )),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 200.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RandomNumberPage()));
                    },
                    child: Text(
                      'Generate Random Number',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white),
                      ),
                      backgroundColor: Colors.transparent.withOpacity(0), //
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RandomYesNopage()));
                    },
                    child: Text(
                      'Yes or No',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 50),
                      // Kích thước mong muốn (200 chiều rộng, 50 chiều cao)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white),
                      ),
                      backgroundColor: Colors.transparent.withOpacity(0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RandomNumberPage extends StatefulWidget {
  @override
  _RandomNumberPageState createState() => _RandomNumberPageState();
}

class _RandomNumberPageState extends State<RandomNumberPage> {
  List<int> _History = [];
  bool _isDrawer2Open = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  String _URL = 'assets/images/1.jpg';
  int _randomNumber = 0;

  void addHistory(int input) {
    setState(() {
      _History.add(input);
    });
  }

  void _openDrawer2() {
    setState(() {
      _isDrawer2Open = !_isDrawer2Open; // Toggle the value of _isDrawer2Open
    });
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.2),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: double.maxFinite,
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('Theme 1'),
                  onTap: () {
                    setState(() {
                      _URL = 'assets/images/1.jpg';
                    });
                    Navigator.pop(context); // Đóng hộp thoại
                  },
                ),
                ListTile(
                  title: Text('Theme 2'),
                  onTap: () {
                    setState(() {
                      _URL = 'assets/images/2.jpg';
                    });
                    Navigator.pop(context); // Đóng hộp thoại
                  },
                ),
                ListTile(
                  title: Text('Theme 3'),
                  onTap: () {
                    setState(() {
                      _URL = 'assets/images/3.jpg';
                    });
                    Navigator.pop(context); // Đóng hộp thoại
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _generateRandomNumber() {
    int start = int.tryParse(_startController.text) ?? 0;
    int end = int.tryParse(_endController.text) ?? 0;
    if (start >= end) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('The start value must be less than the end value.'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      _randomNumber = Random().nextInt(end - start + 1) + start;
      addHistory(_randomNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.lightBlueAccent.withOpacity(0.5),
          child: Column(
            children: <Widget>[
              SizedBox(height: 150),
              _History.isEmpty
                  ? Row(
                      children: [
                        SizedBox(
                          width: 80,
                        ),
                        Text(
                          'No history available',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: false,
                        itemCount: _History.length,
                        itemBuilder: (context, index) {
                          final history = _History[index];
                          return Align(
                            alignment: Alignment.center,
                            child: Text(
                              ' ${history}',
                              style: TextStyle(
                                fontSize: 80,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              SizedBox(height: 50),
              Row(
                children: [
                  SizedBox(
                    width: 107,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _History = [];
                      });
                    },
                    child: Text(
                      'Clear History',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white),
                      ),
                      backgroundColor: Colors.transparent.withOpacity(0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              // image: NetworkImage(_URL),
              image: AssetImage(_URL),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                    ),
                    SizedBox(
                      width: 0,
                    ),
                    IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      icon: Icon(Icons.list),
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                    ),
                    SizedBox(
                      width: 200,
                    ),
                    IconButton(
                      onPressed: () {
                        _showAlertDialog();
                      },
                      icon: Icon(Icons.settings),
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$_randomNumber',
                          style:
                              TextStyle(fontSize: 100.0, color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _startController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Start',
                            labelStyle: TextStyle(color: Colors.white),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    20.0), // Đặt lề ngang cho phần nội dung
                            // border: OutlineInputBorder(), // Đặt đường viền cho TextField
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _endController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'End',
                            labelStyle: TextStyle(color: Colors.white),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    20.0), // Đặt lề ngang cho phần nội dung
                            // border: OutlineInputBorder(), // Đặt đường viền cho TextField
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: _generateRandomNumber,
                          child: Text(
                            'Generate Random Number',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(200, 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.white),
                            ),
                            backgroundColor:
                                Colors.transparent.withOpacity(0), //
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}

class RandomYesNopage extends StatefulWidget {
  @override
  _RandomYesNopageState createState() => _RandomYesNopageState();
}

class _RandomYesNopageState extends State<RandomYesNopage> {
  List<int> _History = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  String _URL = 'assets/images/1.jpg';

  void addHistory(int input) {
    setState(() {
      _History.add(input);
    });
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.2),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: double.maxFinite,
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('Theme 1'),
                  onTap: () {
                    setState(() {
                      _URL = 'assets/images/1.jpg';
                    });
                    Navigator.pop(context); // Đóng hộp thoại
                  },
                ),
                ListTile(
                  title: Text('Theme 2'),
                  onTap: () {
                    setState(() {
                      _URL = 'assets/images/2.jpg';
                    });
                    Navigator.pop(context); // Đóng hộp thoại
                  },
                ),
                ListTile(
                  title: Text('Theme 3'),
                  onTap: () {
                    setState(() {
                      _URL = 'assets/images/3.jpg';
                    });
                    Navigator.pop(context); // Đóng hộp thoại
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String result = '';


  void generateRandomAnswer() {

    Future.delayed(Duration(seconds: 0), () {
      final random = Random();
      bool randomBool = random.nextBool();
      setState(() {
        result = randomBool ? 'Yes' : 'No';
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          result= ''; // Ẩn dòng chữ sau 1 giây
        });
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_URL),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  width: 220,
                ),
                IconButton(
                  onPressed: () {
                    _showAlertDialog();
                  },
                  icon: Icon(Icons.settings),
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            SizedBox(
              height: 80,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(result,style: TextStyle(fontSize: 80,color: Colors.white),),
                    SizedBox(height: 50.0),
                    ElevatedButton(
                      onPressed: generateRandomAnswer,
                      child: Text(
                        'Yes or NO',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(200, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white),
                        ),
                        backgroundColor: Colors.transparent.withOpacity(0),
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
