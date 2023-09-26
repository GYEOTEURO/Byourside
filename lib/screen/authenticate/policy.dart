import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/widget/title_only_appbar.dart';


class Policy extends StatefulWidget {
  const Policy({
    Key? key,
    required this.policy
  }) : super(key: key);

  final Map<String, String> policy;

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
        appBar: titleOnlyAppbar(context, widget.policy['policyName']!),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: [
                  Text(
                    widget.policy['policyContent']!,
                    semanticsLabel: widget.policy['policyContent'],
                    style: TextStyle(
                      fontFamily: fonts.font,
                      fontSize: deviceHeight * 0.018,
                      color: colors.textColor,
                      fontWeight: FontWeight.w400,
                    )
                  )
            ])
        )),
      );
  }
}
