import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/widget/common/title_only_appbar.dart';
import 'package:flutter/material.dart';

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
                    style: const TextStyle(
                      color: colors.textColor,
                      fontSize: 13,
                      fontFamily: fonts.font,
                      fontWeight: FontWeight.w400,
                      height: 1.77,
                    )
                  )
            ])
        )),
      );
  }
}
