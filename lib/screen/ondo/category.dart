import 'package:byourside/screen/nanum/nanumPostCategory.dart';
import 'package:byourside/screen/ondo/info_detail_category.dart';
import 'package:byourside/screen/ondo/overlay_controller.dart';
import 'package:byourside/screen/ondo/post_list.dart';
import 'package:byourside/screen/ondo/postPage.dart';
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

  List<String>? _type;

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
    var controller = Get.put(OndoTypeController());
    var overlayController = Get.put(OverlayController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.filter_alt,
            semanticLabel: '장애 유형 필터링',
          ),
          onPressed: () async {
            HapticFeedback.lightImpact(); // 약한 진동
            if(overlayController.overlayEntry != null){
              overlayController.controlOverlay(null);
            }
            _type = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NanumPostCategory(
                          primaryColor: const Color(0xFF045558),
                          title: '필터링',
                          preType: _type,
                        )));
            print('IN 온도 타입: $_type');
            controller.filtering(_type);
            setState(() {});
          },
        ),
        title: const Center(
          child: Text('마음온도',
              semanticsLabel: '마음온도',
              style: TextStyle(
                  fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              semanticLabel: '검색',
            ),
            onPressed: () {
              HapticFeedback.lightImpact(); // 약한 진동
              if(overlayController.overlayEntry != null){
                overlayController.controlOverlay(null);
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OndoSearch()));
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: categoryTabs,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          onTap: (value) {
            if(overlayController.overlayEntry != null){
              overlayController.controlOverlay(null);
            }
          },
        ),
        backgroundColor: const Color(0xFF045558),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categoryTabs.map((Tab tab) {
          String label = tab.text!;
          if (label == '정보') {
            return Container(
                padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                child: const InfoDetailCategoryPage(
                    primaryColor: Color(0xFF045558),
                    collectionName: 'ondoPost'));
          }
          return OndoPostList(
              primaryColor: const Color(0xFF045558),
              collectionName: 'ondoPost',
              category: label);
        }).toList(),
      ),
      // 누르면 글 작성하는 PostPage로 navigate하는 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact(); // 약한 진동
          if(overlayController.overlayEntry != null){
              overlayController.controlOverlay(null);
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OndoPostPage(
                        // PostPage 위젯에 primartColor와 title명을 인자로 넘김
                        primaryColor: Color(0xFF045558),
                        title: '마음온도 글쓰기',
                      )));
        },
        backgroundColor: const Color(0xFF045558),
        child: const Icon(Icons.add, semanticLabel: '마음온도 글쓰기'),
      ),
    );
  }
}
