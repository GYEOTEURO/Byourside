// import 'package:flutter/material.dart';
// import 'package:byourside/constants/colors.dart' as colors;
// import 'package:byourside/constants/fonts.dart' as fonts;
// import 'package:byourside/constants/constants.dart' as constants;

// class DisabilityTypeSectionInAddPost extends StatefulWidget {

//   const DisabilityTypeSectionInAddPost({Key? key, required this.onDisabilityTypeSelected})
//       : super(key: key);


//   final ValueChanged<String> onChipSelected;  

//   @override
//   _DisabilityTypeSectionInAddPostState createState() =>
//       _DisabilityTypeSectionInAddPostState();
// }

// class _DisabilityTypeSectionInAddPostState
//     extends State<DisabilityTypeSectionInAddPost> {
//   late String _selectedType;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           '장애 유형을 선택해주세요',
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey,
//           ),
//         ),
//         const SizedBox(height: 8), // 텍스트와 버튼 간격
//         Row(
//           children: [
//             buildDisabilityTypeChip('뇌병변 장애'),
//             buildDisabilityTypeChip('발달 장애'),
//             buildDisabilityTypeChip('해당없음'),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget buildDisabilityTypeChip(String type) {
//     return Row(children: [for(String disabilityType in constants.communityDisabilityTypes) ChoiceChip(
//       label: Text(
//                   disabilityType,
//                   style: const TextStyle(
//                         color: colors.textColor,
//                         fontSize: fonts.bodyPt,
//                         fontFamily: fonts.font
//                   )
//                 ),
//       selected: selectedChip ==disabilityType,
//                 onSelected: (bool selected) {
//                   setState(() {
//                     if (selected) {
//                       selectedChip = widget.category[i];
//                       widget.onChipSelected(selectedChip);
//                     }
//                   });
//                 },
//                 clipBehavior: Clip.antiAlias,
//                 shape: RoundedRectangleBorder(
//                   side: const BorderSide(width: 0.50, color: colors.primaryColor),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 selectedColor: colors.primaryColor,
//                 backgroundColor: Colors.white,
//                 disabledColor: Colors.white,
//             )
//           ]);
//   }
// }

// Widget build(BuildContext context) {
//     return Container(
//       color: colors.appBarColor,
//       padding: const EdgeInsets.fromLTRB(20, 0, 14, 23),
//       child: Row(
//         children: [
//         for(int i=0; i<widget.category.length; i++)
//           Container(
//             padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
//             child: ChoiceChip(
//                 label: Text(
//                   widget.category[i],
//                   style: const TextStyle(
//                         color: colors.textColor,
//                         fontSize: fonts.bodyPt,
//                         fontFamily: fonts.font
//                   )
//                 ),
//                 selected: selectedChip == widget.category[i],
//                 onSelected: (bool selected) {
//                   setState(() {
//                     if (selected) {
//                       selectedChip = widget.category[i];
//                       widget.onChipSelected(selectedChip);
//                     }
//                   });
//                 },
//                 clipBehavior: Clip.antiAlias,
//                 shape: RoundedRectangleBorder(
//                   side: const BorderSide(width: 0.50, color: colors.primaryColor),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 selectedColor: colors.primaryColor,
//                 backgroundColor: Colors.white,
//                 disabledColor: Colors.white,
//             )
//           )
//         ]));
    
//   }
// }

