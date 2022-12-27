import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String name;
  final String date;
  final bool me;

  const ChatMessage({super.key, required this.text, required this.me,  required this.name, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
        me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
          ),
          Material(
            color: me ? Colors.blueGrey[100] : Colors.redAccent[100],
            elevation: 6,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                text,
              ),
            ),
          )
        ],
      ),
    );
  }
}

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: primaryColor,
//             child: Text(name),
//           ),
//           SizedBox(
//             width: 16,
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(text)
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
