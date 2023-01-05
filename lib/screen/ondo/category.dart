import 'package:byourside/screen/nanum/nanumPostCategory.dart';
import 'package:byourside/screen/ondo/infoDetailCategory.dart';
import 'package:byourside/screen/ondo/info_test.dart';
import 'package:byourside/screen/ondo/postList.dart';
import 'package:byourside/screen/ondo/search_page.dart';
import 'package:byourside/screen/ondo/type_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:flutter/src/widgets/basic.dart' as C;

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  List<String> _infoDetailList = [
    "전체",
    "복지/혜택",
    "교육/세미나",
    "병원/센터 후기",
    "법률/제도",
    "초기 증상 발견/생활 속 Tip"
  ];
  String _selectedInfoDetail = "전체";

  String? _type;

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
    final controller = Get.put(OndoTypeController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.filter_alt,
            semanticLabel: "장애 유형 필터링",
          ),
          onPressed: () async {
            HapticFeedback.lightImpact(); // 약한 진동
            _type = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NanumPostCategory(
                          primaryColor: Color(0xFF045558),
                          title: "필터링",
                          preType: _type,
                        )));
            print("IN 온도 타입: ${_type}");
            controller.filtering(_type);
            setState(() {});
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
              HapticFeedback.lightImpact(); // 약한 진동
              showSearch(context: context, delegate: Search('ondoPost'));
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
          String label = tab.text!;
          if (label == '정보') {
            return Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: infoDetailCategoryPage(
                    primaryColor: Color(0xFF045558), collectionName: "ondoPost")
                //infoTest(primaryColor: Color(0xFF045558), collectionName: "ondoPost")
                );
          }
          return OndoPostList(
              primaryColor: Color(0xFF045558),
              collectionName: "ondoPost",
              category: label);
        }).toList(),
      ),
    );
  }
}
