import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/';

  const MainScreen();

  @override
  _MainScreenState createState() => _MainScreenState();
}

enum FieldType {
  STRING,
  NUMBER,
  BOOLEAN,
  MAP,
  ARRAY,
  NULL,
  TIMESTAMP,
  GEOPOINT,
  REFERENCE,
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController collectionIdcontroller = TextEditingController();
  final TextEditingController documentIdController = TextEditingController();
  final TextEditingController fieldController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  late String dropdownSelection;

  @override
  void initState() {
    super.initState();
    dropdownSelection = FieldType.STRING.toString();
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
            TextField(
              decoration: const InputDecoration(label: Text('CollectionID')),
              controller: collectionIdcontroller,
            ),
            TextField(
              decoration: const InputDecoration(label: Text('DocumentID')),
              controller: documentIdController,
            ),
            TextField(
              decoration: const InputDecoration(label: Text('Field')),
              controller: fieldController,
            ),
            DropdownButton<String>(
              value: dropdownSelection,
              items: FieldType.values
                  .map(
                    (e) => DropdownMenuItem<String>(value: e.toString(), child: Text(e.toString())),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => dropdownSelection = FieldType.values.firstWhere((element) => element.toString() == value).toString());
              },
            ),
            TextField(
              decoration: InputDecoration(label: Text('Value')),
              controller: valueController,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
                onPressed: () async {
                  final CollectionReference collection = await FirebaseFirestore.instance.collection(collectionIdcontroller.text);
                  // final DocumentReference document = collection.doc(documentIdController.text);
                  // final DocumentSnapshot snapshot = await document.get();
                  // final bool hasData = snapshot.data() != null;
                  // if (hasData) {
                  //   document.update({fieldController.text: valueController.text});
                  // } else {
                  //   document.set({fieldController.text: valueController.text});
                  // }

                  collection.withConverter(
                    fromFirestore: (snapshot, options) {},
                    toFirestore: (value, options) {
                      return {
                        '': 3,
                      }
                    },
                  );
                },
                child: const Text('Submit')),
            SizedBox(
              height: 48,
            ),
            Divider(),
            SizedBox(
              height: 48,
            ),
            Text('Viewing \'users\' (col):', style: TextStyle(fontSize: 18)),
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
