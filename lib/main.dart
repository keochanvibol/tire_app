import 'package:flutter/material.dart';
import 'package:sqlite_input/connection.dart';
import 'package:sqlite_input/datauser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerName = TextEditingController();
  late ConnectionDB db;
  Future<List<User>>? listuser;
  Future<List<User>> getList() async {
    return await db.getUser();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = ConnectionDB();
    db.initializeDB().whenComplete(() {
      setState(() {
        listuser = db.getUser();
        print(listuser!.then((value) => value.first.name.toString()));
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('SQLITE DATA')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controllerName,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
              ),
            ),
            Container(
              height: 400,

            ),
          ],
        ),
      ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){},child: const Text('Add')),
    );
  }
}