import 'package:byourside/screen/ondo/eduSemina.dart';
import 'package:byourside/screen/ondo/eduViewPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> categoryTabs = <Tab>[
    Tab(text: '전체'),
    Tab(text: '자유'),
    Tab(text: '정보'),
  ];

  @override
  void initState() {
    _tabController = TabController(
      length: categoryTabs.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.filter_alt,
            semanticLabel: "필터링",
          ),
          onPressed: () {
            debugPrint("Filter Icon Clicked");
          },
        ),
        title: Center(
          child: Text("마음온도"),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: "검색",
            ),
            onPressed: () {
              debugPrint("검색 Icon Clicked");
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: categoryTabs,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.grey,
        ),
        backgroundColor: Color(0xFF045558),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categoryTabs.map((Tab tab) {
          final String label = tab.text!;
          return Center(
            child: Text(
              "This is the $label tab",
              style: const TextStyle(fontSize: 30),
            ),
          );
        }).toList(),
        // children: <Widget>[
        //   Text(
        //     "This is the 전체 tab",
        //     style: const TextStyle(fontSize: 30),
        //   ),
        //   Text(
        //     "This is the 자유 tab",
        //     style: const TextStyle(fontSize: 30),
        //   ),
        //   PostList(primaryColor: Color(0xFF045558))
        // ],
      ),
    );
  }
}
