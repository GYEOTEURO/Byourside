import 'package:byourside/model/db_get.dart';
import 'package:byourside/model/post_list.dart';
import 'package:byourside/screen/nanum/nanumPost.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String? selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    return NanumPost(collectionName: collectionName, documentID: selectedResult!, primaryColor: Color(0xFF045558));
  }

  final String collectionName;
  Search(this.collectionName) : super(searchFieldLabel: "검색어를 입력하세요.");

  @override
  Widget buildSuggestions(BuildContext context) {

    Widget _buildListItem(PostListModel? post){
    
    String date = post!.datetime!.toDate().toString().split(' ')[0];
    String isCompleted = (post.isCompleted == true) ? "거래완료" : "거래중";
              
    return Container(
        height: 90,
        child: Card(
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    selectedResult = post.id;
                    print(selectedResult);
                    showResults(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,                     
                                    children: [
                                      Text(
                                        post.title!,
                                        style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                      Text(
                                        '${post.nickname} / $date / $isCompleted',
                                        style: const TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  
                                ],
                            ),
                      )
           )));
  }

    return StreamBuilder<List<PostListModel>>(
      stream: DBGet.readSearchDocs(query, collection: collectionName),
      builder: (context, AsyncSnapshot<List<PostListModel>> snapshot) {
              if(snapshot.hasData) {
                return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  PostListModel post = snapshot.data![index];
                  return _buildListItem(post);
                });
              }
              else return Text("");
          }
        );
      }
}