import 'package:delevary/app/Services/Api/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class GoogleButtonComponent extends StatelessWidget {
  final void Function() onCompleted;
   GoogleButtonComponent({super.key, required this.onCompleted});
  void login (BuildContext context){

    AuthBySocialService authService = AuthBySocialService();
    authService.signin(
        onCompleted: onCompleted,
        context: context);

  }
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        login(context);
      },
      child: SizedBox(
        height: 50.h,
        width: 50.w,
        child: Card(
          elevation: 3,
          shadowColor: Colors.black38,
          margin: EdgeInsets.zero,
        child:Padding(
          padding: EdgeInsets.all(12.sp),
          child: Image.asset("assets/images/v2/google.png",width: 31.w,height: 31.h,fit: BoxFit.cover,),
        ) ,
      ),
      ),
    ) ;
  }
}
