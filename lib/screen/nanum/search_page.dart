import 'package:byourside/model/db_get.dart';
import 'package:byourside/model/post_list.dart';
import 'package:byourside/screen/nanum/nanumPost.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close, semanticLabel: "입력 내용 지우기"),
        onPressed: () {
          HapticFeedback.lightImpact();// 약한 진동
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, semanticLabel: "뒤로 가기"),
      onPressed: () {
        HapticFeedback.lightImpact();// 약한 진동
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
                    HapticFeedback.lightImpact();// 약한 진동
                    selectedResult = post.id;
                    print(selectedResult);
                    showResults(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [
                        Expanded(
                                 child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,                     
                                    children: [
                                      SelectionArea(
                                        child: Text(
                                          post.title!,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                      ))),
                                      SelectionArea(
                                        child: Text(
                                          '${post.nickname} / $date / $isCompleted',
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: const TextStyle(color: Colors.black54),
                                      )),
                                    ],
                                  )),
                                  if (post.images!.isNotEmpty)
                                    Semantics(
                                      label: '사용자가 올린 사진',
                                      child: Image.network(
                                      post.images![0],
                                      width: 100,
                                      height: 100,
                                  )), 
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