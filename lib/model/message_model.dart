import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id; //해당 도큐먼트의 ID를 담기위함.
  final String content;
  final Timestamp sendDate;

  MessageModel({
    this.id = '',
    this.content = '',
    Timestamp? sendDate,
  }):sendDate = sendDate??Timestamp(0, 0);

  //서버로부터 map형태의 자료를 MessageModel형태의 자료로 변환해주는 역할을 수행함.
  factory MessageModel.fromMap({required String id,required Map<String,dynamic> map}){
    return MessageModel(
        id: id,
        content: map['content']??'',
        sendDate: map['sendDate']??Timestamp(0, 0)
    );
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> data = {};
    data['content']=content;
    data['sendDate']=sendDate;
    return data;
  }

}