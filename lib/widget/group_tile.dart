import 'package:byourside/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screen/chat/chat_page.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  final String recentMsg;

  const GroupTile(
      {Key? key,
      required this.userName,
      required this.groupId,
      required this.groupName,
      required this.recentMsg})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact(); // 약한 진동
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        groupId: widget.groupId,
                        groupName: widget.groupName,
                        userName: widget.userName,
                      )));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                (widget.groupName.split('_')[0] == widget.userName)
                    ? widget.groupName
                        .split('_')[1]
                        .substring(0, 1)
                        .toUpperCase()
                    : widget.groupName.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            title: Text(
              widget.groupName,
              semanticsLabel: widget.groupName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            subtitle: Text(
              // widget.recentMsg,
              widget.groupId, semanticsLabel: widget.groupId,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ));
  }
}
