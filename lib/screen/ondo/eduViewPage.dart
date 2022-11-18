import 'package:byourside/screen/ondo/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EduViewPage extends StatefulWidget {
  const EduViewPage({Key? key}) : super(key: key);

  @override
  State<EduViewPage> createState() => _EduViewPageState();
}

class _EduViewPageState extends State<EduViewPage> {
  List<Card> _buildGridCards(BuildContext context) {
    // List<EduSemina> eduseminas = ProductsRepository.loadProducts(Category.all);

    // if (products == null || products.isEmpty) {
    return const <Card>[];
  }

  //   final ThemeData theme = Theme.of(context);
  //   final NumberFormat formatter = NumberFormat.simpleCurrency(
  //       locale: Localizations.localeOf(context).toString());

  //   return products.map((product) {
  //     return Card(
  //       clipBehavior: Clip.antiAlias,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           AspectRatio(
  //             aspectRatio: 18 / 11,
  //             child: Image.asset(
  //               product.assetName,
  //               package: product.assetPackage,
  //               fit: BoxFit.fitWidth,
  //             ),
  //           ),
  //           Expanded(
  //             child: Padding(
  //               padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text(
  //                     product.name,
  //                     style: theme.textTheme.titleMedium,
  //                     maxLines: 1,
  //                   ),
  //                   SizedBox(height: 8.0),
  //                   Text(
  //                     formatter.format(product.price),
  //                     style: theme.textTheme.bodyMedium,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }

  // final String fnTitle = "title";
  // final String fnContent = "content";
  // final String fnDatetime = "datetime";

  // List<Card> _buildListItem(BuildContext context, DocumentSnapshot document) {
  //   Timestamp t = document[fnDatetime];
  //   DateTime d = t.toDate();
  //   String date = d.toString();
  //   date = date.split(' ')[0];

  //   return Card(
  //       elevation: 2,
  //       child: InkWell(
  //         //Read Document
  //         onTap: () {
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => Post(
  //                         // Post 위젯에 documentID를 인자로 넘김
  //                         documentID: document.id,
  //                       )));
  //         },
  //         child: Container(
  //           padding: const EdgeInsets.all(8),
  //           child: Column(
  //             children: <Widget>[
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Text(
  //                     document[fnTitle],
  //                     style: const TextStyle(
  //                       color: Colors.blueGrey,
  //                       fontSize: 17,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   )
  //                 ],
  //               ),
  //               Container(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   date,
  //                   style: const TextStyle(color: Colors.black54),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: _buildGridCards(context),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
