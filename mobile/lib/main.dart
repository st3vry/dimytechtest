import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'coffee.dart';

Future<List<Coffee>> fetchCoffee() async {
  final response =
      await http.get(Uri.parse('https://api.sampleapis.com/coffee/hot'));
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Coffee>((json) => Coffee.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Login'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final pinController = TextEditingController();

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  int checkPin() {
    if (int.tryParse(pinController.text) == null) {
      return 0;
    } else if (pinController.text == '2022') {
      return 1;
    } else {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: pinController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Pin',
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Open route'),
              onPressed: () {
                switch(checkPin()){
                  case 0:
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text("Only numbers are allowed!"),
                        );
                      },
                    );
                    break;
                  case 1: 
                   Navigator.push(context,MaterialPageRoute(builder: (context) => const HomePage(title: 'Home')),);
                    break;
                  case 2:
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text("Oops, sorry wrong pin!"),
                        );
                      },
                    );
                    break;
                }
              },
            )
          ],
        )
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);
  final String text;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return new Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
      new AnimatedSize(
          vsync: this,
          duration: const Duration(milliseconds: 300),
          child: new ConstrainedBox(
              constraints: new BoxConstraints(),
              child: new Text(
                widget.isExpanded ? widget.text : widget.text.length > 100 ? widget.text.substring(0,100)+"..." : widget.text,
                softWrap: true,
                overflow: TextOverflow.fade,
              ))),
      widget.isExpanded ? 
          new TextButton(
          child: const Text(
            'Show less',
            textAlign: TextAlign.left,
            ),
          onPressed: () => setState(() => widget.isExpanded = false))
          : new TextButton(
          child: const Text(
            'Show more',
            textAlign: TextAlign.left,
            ),
          onPressed: () => setState(() => widget.isExpanded = true))
    ]);
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<List<Coffee>> futureCoffee;

  @override
  void initState() {
    super.initState();
    futureCoffee = fetchCoffee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder<List<Coffee>>(
        future: futureCoffee,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    width: 0.2,
                  ),
                ),
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget> [
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              children: [
                                SizedBox(
                                  child: Image.network(
                                    "${snapshot.data![index].image}",
                                    fit: BoxFit.cover,
                                    errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) { return const Text('Image Not Found!');},
                                    loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.fromLTRB(20,10,20,0),
                              color: Color.fromRGBO(255,255, 255, 0.4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${snapshot.data![index].title}",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10,0,10,0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ExpandableText("${snapshot.data![index].description}")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10,0,10,0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (int i=0; i<snapshot.data![index].ingredients.length; i++)
                                  // Text("Hello" + i)
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child:Chip(
                                      label: Text("${snapshot.data![index].ingredients[i]}"),
                                    )
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                  ]
                )
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

