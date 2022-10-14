import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  final String fnName = "name";
  final String fnAge = "age";
  final String fnDatetime = "datetime";

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return  Card(
              elevation: 2,
              child: InkWell(
                // Read Document
                // onTap: () {
                //   showDocument(document.id);
                // },
                // // Update or Delete Document
                // onLongPress: () {
                //   showUpdateOrDeleteDocDialog(document);
                // },
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
                          style: TextStyle(color: Colors.black54),
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
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
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
      )
    );
  }
}



  