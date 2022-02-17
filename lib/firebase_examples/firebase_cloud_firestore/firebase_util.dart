// ignore_for_file: slash_for_doc_comments

import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * 
 *  Description:
 *  Adds data to a document. If the document does not exist, it will be craeted.
 *  If documentName is null, then it will be auto generated.
 *  If data is null, a blank document will be created.
 *  
 *  Requirements:
 *  path.length >= 0 && path.length % 2 != 0
 * 
 *  Example usage:
 *  // Create a document named "poopy" with field "count" of value 10
 *  // inside users (collection) > x23mark (document) > lemon (collection)
 *  // Documents must be in a collection. (That's why path.length must be odd)
 *  add(['users', 'x23mark', 'lemon'], documentName: 'poopy', {'count': 10});
 */
Future<DocumentReference<Object?>?> addData(List<String> path, {String? documentName, Map<String, dynamic>? data}) async {
  if (path.isEmpty || path.length % 2 == 0) {
    return Future.value(null);
  }
  CollectionReference colRef = FirebaseFirestore.instance.collection(path[0]);
  late DocumentReference docRef;
  for (int i = 1; i < path.length; i++) {
    if (i % 2 == 0) {
      colRef = docRef.collection(path[i]);
    } else {
      docRef = colRef.doc(path[i]);
    }
  }
  data ??= {}; // if null, make it = {}
  if (documentName != null) {
    docRef = colRef.doc(documentName);
    bool hasData = (await docRef.get()).data() != null;

    if (hasData) {
      // Case 1: Document already exists
      docRef.update(data);
    } else {
      // Case 2: Document does not exist
      docRef.set(data);
    }
    return Future.value(docRef);
  } else {
    return colRef.add(data);
  }
}

/**
 * Description:
 * Creates/updates a document given a path that ends with a collection.
 * 
 * Requirements:
 * path must have an even number of '/' (slashes) in the path. Example: 'users/x23mark/info'
 * 
 * Example usage:
 * String path = 'users/x23mark/info'
 * String documentName = 'address';
 * String data = {'lemon': 3};
 * addDataStringPath(path, documentName: documentName, data: data);
 */
Future<DocumentReference<Object?>?> addDataStringPath(String path, {String? documentName, Map<String, dynamic>? data}) async {
  final CollectionReference colRef = FirebaseFirestore.instance.collection(path);
  data ??= {};
  if (documentName != null) {
    final DocumentReference docRef = colRef.doc(documentName);
    bool hasData = (await docRef.get()).data() != null;
    if (hasData) {
      docRef.update(data);
    } else {
      docRef.set(data);
    }
  } else {
    final DocumentReference docRef = await colRef.add(data);
    return docRef;
  }
}

/**
 *  Get the list of document ids in a collection
 *  []
 *  ['users']
 *  ['users', 'x23mark', 'lemon']
 */
Future<List<String>?> getDocumentIds(List<String> path) async {
  if (path.length != 0 && path.length % 2 == 0) {
    return Future.value(null);
  }
  CollectionReference colRef;
  if (path.length == 0) {
    FirebaseFirestore.instance.collectionGroup('/');
  } else {
    for (int i = 0; i < path.length; i++) {}
  }
}
