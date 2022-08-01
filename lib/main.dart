import 'dart:math';

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

  Future<void> _onRefresh() async {
    setState(() {
      listuser = db.getUser();
      Future.delayed(const Duration(seconds: 5));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onRefresh();
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
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 600,
              width: double.infinity,
              child: FutureBuilder(
                future: listuser,
                builder: (context, AsyncSnapshot<List<User>> snapshoot) {
                  if (snapshoot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return snapshoot.hasError
                      ? const Center(
                          child: Icon(
                            Icons.info,
                            color: Colors.red,
                          ),
                        )
                      : ListView.builder(
                          itemCount: snapshoot.data!.length,
                          itemBuilder: (context, index) {
                            var item = snapshoot.data![index];
                            return InkWell(
                              onLongPress: () async {
                                await ConnectionDB()
                                    .deleteUser(item.id)
                                    .whenComplete(() {
                                  setState(() {
                                    print('Delect Sucess');
                                    _onRefresh();
                                  });
                                });
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(item.name),
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await ConnectionDB()
                .insertUser(User(
                    id: Random().nextInt(100),
                    name: controllerName.text.trim()))
                .whenComplete(() {
              print('insert sucess');
              _onRefresh();
              controllerName.clear();
            });
          },
          child: const Text('Add')),
    );
  }
}
