import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/constants.dart' as constants;

class CategorySectionInAddPost extends StatefulWidget {
  const CategorySectionInAddPost({Key? key, required this.onChipSelected})
      : super(key: key);

  final ValueChanged<String> onChipSelected;

  @override
  _CategorySectionInAddPostState createState() =>
      _CategorySectionInAddPostState();
}

class _CategorySectionInAddPostState extends State<CategorySectionInAddPost> {
  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _selectedCategory = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
        child: Column(children: [
          const Text(
            '어떤 종류의 글을 쓰실 건가요?',
            semanticsLabel: '어떤 종류의 글을 쓰실 건가요?',
            style: TextStyle(
                color: colors.textColor,
                fontWeight: FontWeight.bold,
                fontSize: fonts.bodyPt,
                fontFamily: fonts.font),
          ),
          Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (int i = 1; i < 4; i++)
                    Container(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: ChoiceChip(
                          label: Text(constants.communityCategories[i],
                              style: const TextStyle(
                                  color: colors.textColor,
                                  fontSize: fonts.captionTitlePt,
                                  fontFamily: fonts.font)),
                          selected: _selectedCategory ==
                              constants.communityCategories[i],
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                _selectedCategory =
                                    constants.communityCategories[i];
                                widget.onChipSelected(_selectedCategory);
                              }
                            });
                          },
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50, color: colors.primaryColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          selectedColor: colors.primaryColor,
                          backgroundColor: Colors.white,
                          disabledColor: Colors.white,
                        ))
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (int i = 4; i < constants.communityCategories.length; i++)
                    Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: ChoiceChip(
                          label: Text(constants.communityCategories[i],
                              style: const TextStyle(
                                  color: colors.textColor,
                                  fontSize: fonts.captionTitlePt,
                                  fontFamily: fonts.font)),
                          selected: _selectedCategory ==
                              constants.communityCategories[i],
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                _selectedCategory =
                                    constants.communityCategories[i];
                                widget.onChipSelected(_selectedCategory);
                              }
                            });
                          },
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50, color: colors.primaryColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          selectedColor: colors.primaryColor,
                          backgroundColor: Colors.white,
                          disabledColor: Colors.white,
                        ))
                ])
              ]))
        ]));
  }
}
