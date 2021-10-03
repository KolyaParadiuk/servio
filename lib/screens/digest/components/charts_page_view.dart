import 'package:flutter/material.dart';
import 'package:servio/components/loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChartsPageView extends StatelessWidget {
  final PageController controller = PageController();
  final List<Widget> children;
  final bool loading;
  ChartsPageView({
    required this.children,
    this.loading = false,
  });

  @override
  build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                  onTap: () {
                    controller.previousPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
                  },
                  child: Container(width: 6.w, child: Icon(Icons.arrow_back_ios, size: 16))),
              Expanded(
                child: PageView(
                  controller: controller,
                  children: children,
                ),
              ),
              InkWell(
                  onTap: () {
                    controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
                  },
                  child: Container(width: 10.w, child: Icon(Icons.arrow_forward_ios, size: 16))),
            ],
          ),
        ),
        this.loading ? Loading() : SizedBox.shrink()
      ],
    );
  }
}
