import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension RefreshExtention on Widget {
  Widget refreshAbel({required Future Function() onRefresh}) {
    return RefreshIndicator(

      onRefresh: ()async {
       await onRefresh();
        return Future(() => false);
      },
      child: this,
    );
  }
}
