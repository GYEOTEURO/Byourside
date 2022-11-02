import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostList extends StatelessWidget {
  PostList({super.key});

  final String fnName = "name";
  final String fnAge = "age";
  final String fnDatetime = "datetime";

  final TextEditingController _newNameCon = TextEditingController();
  final TextEditingController _newAgeCon = TextEditingController();
  final TextEditingController _undNameCon = TextEditingController();
  final TextEditingController _undAgeCon = TextEditingController();

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    void showUpdateOrDeleteDocDialog(DocumentSnapshot doc) {
      _undNameCon.text = doc[fnName];
      _undAgeCon.text = doc[fnAge];
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update/Delete Document"),
            content: SizedBox(
              height: 200,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(labelText: "Name"),
                    controller: _undNameCon,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: "Description"),
                    controller: _undAgeCon,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FloatingActionButton(
                child: const Text("Cancel"),
                onPressed: () {
                  _undNameCon.clear();
                  _undAgeCon.clear();
                  Navigator.pop(context);
                },
              ),
              FloatingActionButton(
                child: const Text("Update"),
                onPressed: () {
                  if (_undNameCon.text.isNotEmpty &&
                      _undAgeCon.text.isNotEmpty) {
                    updateDoc(doc.id, _undNameCon.text, _undAgeCon.text);
                  }
                  Navigator.pop(context);
                },
              ),
              FloatingActionButton(
                child: const Text("Delete"),
                onPressed: () {
                  deleteDoc(doc.id);
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
  }
    return Card(
              elevation: 2,
              child: InkWell(
                //Read Document
                onTap: () {
                  showDocument(document.id);
                },
                // Update or Delete Document
                onLongPress: () {
                  showUpdateOrDeleteDocDialog(document);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[                                  Row(                                    mainAxisAlignment:                                        MainAxisAlignment.spaceBetween,                                    children: <Widget>[                                      Text(                                       document[fnName],
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          document[fnAge],
                          style: const TextStyle(color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                ),
            )
        );
  }

  @override
  Widget build(BuildContext context) {
    void showCreateDocDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Create New Document"),
          content: SizedBox(
            height: 200,
            child: Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: const InputDecoration(labelText: "Name"),
                  controller: _newNameCon,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: "Age"),
                  controller: _newAgeCon,
                )
              ],
            ),
          ),
          actions: <Widget>[
            FloatingActionButton(
              child: const Text("Cancel"),
              onPressed: () {
                _newNameCon.clear();
                _newAgeCon.clear();
                Navigator.pop(context);
              },
            ),
            FloatingActionButton(
              child: const Text("Create"),
              onPressed: () {
                if (_newAgeCon.text.isNotEmpty &&
                    _newNameCon.text.isNotEmpty) {
                  createDoc(_newNameCon.text, _newAgeCon.text);
                }
                _newNameCon.clear();
                _newAgeCon.clear();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
  
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 500,
            child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('user').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData) return const Text('Loading...');
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data!.docs[index]),
              );
            }),
          )
        ]
      ),
       floatingActionButton: FloatingActionButton(
          onPressed: showCreateDocDialog,
          child: const Icon(Icons.add)
       ),
    );
  }


 // 문서 생성 (Create)
  void createDoc(String name, String age) {
    FirebaseFirestore.instance.collection('user').add({
      fnName: name,
      fnAge: age,
      fnDatetime: Timestamp.now(),
    });
  }

  // 문서 조회 (Read)
  void showDocument(String documentID) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(documentID)
        .get()
        .then((doc) {
      showReadDocSnackBar(doc);
    });
  }

  // 문서 갱신 (Update)
  void updateDoc(String docID, String name, String age) {
    FirebaseFirestore.instance.collection('user').doc(docID).update({
      fnName: name,
      fnAge: age,
    });
  }

  // 문서 삭제 (Delete)
  void deleteDoc(String docID) {
    FirebaseFirestore.instance.collection('user').doc(docID).delete();
  }

  

  void showReadDocSnackBar(DocumentSnapshot doc) {
    SnackBar(
      backgroundColor: Colors.deepOrangeAccent,
      duration: const Duration(seconds: 5),
      content: Text(
          "$fnName: ${doc[fnName]}\n$fnAge: ${doc[fnAge]}"
          "\n$fnDatetime: ${timestampToStrDateTime(doc[fnDatetime])}"),
      action: SnackBarAction(
        label: "Done",
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }

  
  String timestampToStrDateTime(Timestamp ts) {
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
        .toString();
  }
}