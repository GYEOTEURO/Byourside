import 'package:byourside/screen/ondo/posterPage.dart';
import 'package:byourside/screen/ondo/overlay_controller.dart';
import 'package:byourside/screen/ondo/postList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InfoDetailCategoryPage extends StatefulWidget {
  const InfoDetailCategoryPage(
      {Key? key, required this.primaryColor, required this.collectionName})
      : super(key: key);

  final Color primaryColor;
  final String collectionName;

  @override
  State<InfoDetailCategoryPage> createState() => _InfoDetailCategoryPageState();
}

class _InfoDetailCategoryPageState extends State<InfoDetailCategoryPage> {
  final overlayController = Get.put(OverlayController());

  // 드롭다운 리스트.
  static const List<String> _dropdownList = [
    '전체 정보',
    '복지/혜택',
    '교육/세미나',
    '병원/센터 후기',
    '법률/제도',
    '초기 증상 발견/생활 속 Tip'
  ];

  // 선택값.
  String _dropdownValue = '전체 정보';
  String _changePage = '전체 정보';

  // 드롭박스.
  //OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  // 드롭다운 생성.
  void _createOverlay() {
    if (overlayController.overlayEntry == null) {
      overlayController.controlOverlay(_customDropdown());
      Overlay.of(context).insert(overlayController.overlayEntry!);
    }
  }

  // 드롭다운 해제.
  void _removeOverlay() {
    //overlayController.overlayEntry?.remove();
    overlayController.controlOverlay(null);
  }

  @override
  void dispose() {
    try {
      overlayController.overlayEntry?.dispose();
    } catch (e) {
      _removeOverlay();
    } finally {
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
        onTap: () => _removeOverlay(),
        child: Scaffold(
            body: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: () {
                  HapticFeedback.lightImpact(); // 약한 진동
                  _createOverlay();
                },
                child: CompositedTransformTarget(
                  link: _layerLink,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    width: width * 0.79,
                    height: height * 0.07,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 선택값.
                        Text(
                          _dropdownValue,
                          semanticsLabel: _dropdownValue,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 22 / 16,
                            color: Colors.black,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // 아이콘.
                        const Icon(
                          Icons.arrow_downward,
                          semanticLabel: '정보 게시판의 하위 게시판 선택',
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(width * 0.06, height * 0.07),
                      foregroundColor: Colors.white,
                      backgroundColor: widget.primaryColor,
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      setState(() {
                        _changePage = _dropdownValue;
                      });
                    },
                    child: const Text('이동',
                        semanticsLabel: '이동',
                        style: TextStyle(
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w600,
                        ))))
          ]),
          if (_changePage == '교육/세미나' || _changePage == '복지/혜택')
            Expanded(
                child: PosterPage(
                    primaryColor: widget.primaryColor,
                    collectionName: widget.collectionName,
                    category: _changePage))
          else if (_changePage == '전체 정보' ||
              _changePage == '병원/센터 후기' ||
              _changePage == '법률/제도' ||
              _changePage == '초기 증상 발견/생활 속 Tip')
            Expanded(
                child: OndoPostList(
                    primaryColor: const Color(0xFF045558),
                    collectionName: widget.collectionName,
                    category: _changePage))
        ])));
  }

  // 드롭다운.
  OverlayEntry _customDropdown() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: width * 0.8,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, height * 0.07),
          child: Material(
            color: Colors.white,
            child: Container(
              height: (22.0 * _dropdownList.length) +
                  (21 * (_dropdownList.length - 1)) +
                  20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: _dropdownList.length,
                itemBuilder: (context, index) {
                  return CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    pressedOpacity: 1,
                    minSize: 0,
                    onPressed: () {
                      HapticFeedback.lightImpact(); // 약한 진동
                      setState(() {
                        _dropdownValue = _dropdownList.elementAt(index);
                      });
                      _removeOverlay();
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _dropdownList.elementAt(index),
                        semanticsLabel: _dropdownList.elementAt(index),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 22 / 16,
                          color: Colors.black,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Divider(
                      color: Colors.black,
                      height: 20,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
