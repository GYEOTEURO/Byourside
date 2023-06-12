import 'package:byourside/main.dart';
import 'package:byourside/screen/common/block_user.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sentByMe;

  const MessageTile(
      {Key? key,
      required this.message,
      required this.sender,
      required this.sentByMe})
      : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: widget.sentByMe ? 0 : 20,
            right: widget.sentByMe ? 20 : 0),
        alignment:
            widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: widget.sentByMe
              ? const EdgeInsets.only(left: 20)
              : const EdgeInsets.only(right: 20),
          padding:
              const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: widget.sentByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
            color: widget.sentByMe ? primaryColor : Colors.grey[700],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.sentByMe
                  ? Text(
                      widget.sender.toUpperCase(),
                      semanticsLabel: widget.sender,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                        fontFamily: 'NanumGothic',
                      ),
                    )
                  : Row(
                      children: [
                        Text(
                          widget.sender.toUpperCase(),
                          semanticsLabel: widget.sender,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                            fontFamily: 'NanumGothic',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        BlockUser(nickname: widget.sender, collectionType: 'chat')
                      ],
                    ),
              SizedBox(height: height * 0.01),
              Text(
                widget.message,
                semanticsLabel: widget.message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontFamily: 'NanumGothic',
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ));
  }
}
