import 'dart:math';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_input/main.dart';
import 'connection.dart';
import 'datauser.dart';

class UpdateUser extends StatefulWidget {
  int id;
  String name;
  UpdateUser({required this.id, required this.name, Key? key})
      : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  TextEditingController controllerName = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerName.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('SQLITE UPDATE DATA')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controllerName,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await ConnectionDB()
                .updateUser(
                    User(id: widget.id, name: controllerName.text.trim()))
                .whenComplete(() => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (route) => false));
          },
          child: const Text('Update')),
    );
  }
}
