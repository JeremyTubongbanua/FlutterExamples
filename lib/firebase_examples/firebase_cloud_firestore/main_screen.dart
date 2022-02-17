import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './firebase_util.dart' as fb;

class MainScreen extends StatefulWidget {
  static const String routeName = '/';

  const MainScreen();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController collectionIdController = TextEditingController();
  final TextEditingController documentIdController = TextEditingController();
  final TextEditingController fieldController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  late String databaseSelection;
  late String typeSelection;

  @override
  void initState() {
    super.initState();
    collectionIdController.text = 'users';
    documentIdController.text = 'x23mark';

    typeSelection = 'STRING';
    databaseSelection = 'SET';
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(64.0),
        width: width,
        height: height,
        child: ListView(
          children: [
            const Text('Cloud Firestore Example', style: TextStyle(fontSize: 24)),
            const Divider(height: 0),
            const SizedBox(height: 24),
            DropdownButton<String>(
              value: databaseSelection,
              items: const [
                'SET',
                'GET',
                'UPDATE',
                'DELETE',
                'ADD',
              ].map((str) => DropdownMenuItem<String>(child: Text(str), value: str)).toList(),
              onChanged: (value) {
                setState(() {
                  databaseSelection = value!;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(label: Text('CollectionID')),
              controller: collectionIdController,
            ),
            TextField(
              decoration: const InputDecoration(label: Text('DocumentID')),
              controller: documentIdController,
            ),
            DropdownButton<String>(
              value: typeSelection,
              items: [
                'STRING',
                'NUMBER',
              ].map((str) => DropdownMenuItem<String>(child: Text(str), value: str)).toList(),
              onChanged: (value) {
                setState(() => typeSelection = value!);
              },
            ),
            TextField(
              decoration: const InputDecoration(label: Text('Field')),
              controller: fieldController,
            ),
            TextField(
              decoration: const InputDecoration(label: Text('Value')),
              controller: valueController,
              keyboardType: (() {
                switch (typeSelection) {
                  case 'STRING':
                    return TextInputType.text;
                  case 'NUMBER':
                    return TextInputType.number;
                  default:
                    return TextInputType.text;
                }
              })(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final CollectionReference collection = await FirebaseFirestore.instance.collection(collectionIdController.text);
                // final DocumentReference document = collection.doc(documentIdController.text);
                // final DocumentSnapshot snapshot = await document.get();
                // final bool hasData = snapshot.data() != null;
                // if (hasData) {
                //   document.update({fieldController.text: valueController.text});
                // } else {
                //   document.set({fieldController.text: valueController.text});
                // }
              },
              child: const Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () async {
                String path = 'users/x23mark/test';
                String documentName = 'info';
                Map<String, dynamic> data = {'poo': '3'};
                await fb.addDataStringPath(path, documentName: documentName, data: data);
              },
              child: const Text('Quick Test'),
            ),
            const SizedBox(
              height: 48,
            ),
            const Divider(),
            const SizedBox(
              height: 48,
            ),
            const Text('Viewing \'users\' (col):', style: TextStyle(fontSize: 18)),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Snapshot has error?');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Container(
                  height: 300,
                  child: ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) => ListTile(
                              title: Text('${document.id} (doc): ${document.data().toString()}'),
                            ))
                        .toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
