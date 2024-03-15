import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension LoadMoreExtention on Widget {
  Widget loadMoreAble(
      {required ScrollController scrollController,
      required Future Function() onLoadMore}) {
    scrollController.addListener(() {
      loadMore(scrollController, onLoadMore: onLoadMore);
    });

    return this;
  }

  void loadMore(ScrollController scrollController,
      {required Future Function() onLoadMore}) async {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100.h) {
      await onLoadMore();
    }
  }
}
