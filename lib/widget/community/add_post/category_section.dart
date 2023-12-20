import 'package:byourside/constants/text.dart' as text;
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;

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
          Text(
            text.addPostQuestions['category']!,
            semanticsLabel: text.addPostQuestions['cateogry'],
            style: const TextStyle(
                color: colors.textColor,
                fontWeight: FontWeight.bold,
                fontSize: fonts.bodyPt,
                fontFamily: fonts.font),
          ),
          Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: Column(children: [
                for (int paragraph = 0; paragraph < 2; paragraph++)
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    for (int index = 3 * paragraph + 1;
                        index < 3 * paragraph + 4;
                        index++)
                      Container(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: ChoiceChip(
                            label: Text(text.communityCategories[index],
                                style: const TextStyle(
                                    color: colors.textColor,
                                    fontSize: fonts.captionTitlePt,
                                    fontFamily: fonts.font)),
                            selected: _selectedCategory ==
                                text.communityCategories[index],
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  _selectedCategory =
                                      text.communityCategories[index];
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
