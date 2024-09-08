import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nadha/app/data/model/order_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> showOrderInvoice(OrderModel order) async {
  final doc = pw.Document();
  String logo = await rootBundle.loadString('assets/svg/logo.svg');
  final ttf = await fontFromAssetBundle(
      'assets/fonts/Cairo-VariableFont_slnt,wght.ttf');
  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.roll57,
      build: (pw.Context context) {
        return pw.Container(
            child: pw.Expanded(
          child: pw.Column(children: [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.SvgImage(svg: logo, width: 30.w, fit: pw.BoxFit.contain),
              ],
            ),
            pw.Text(
              "رقم الطلب : ${order.orderNo}",
              textAlign: pw.TextAlign.start,
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(
                  font: ttf, fontSize: 4, fontWeight: pw.FontWeight.normal),
            ),
            pw.Divider(thickness: 0.5.sp, height: 2.5.sp),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 5.sp),
                    child: pw.FittedBox(
                      child: pw.Text(
                        'الإجمالي',
                        textAlign: pw.TextAlign.start,
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(
                            font: ttf,
                            fontSize: 4,
                            fontWeight: pw.FontWeight.normal),
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 5.sp),
                    child: pw.FittedBox(
                        child: pw.Text('الكمية',
                            textAlign: pw.TextAlign.start,
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(
                                font: ttf,
                                fontSize: 4,
                                fontWeight: pw.FontWeight.normal),
                            overflow: pw.TextOverflow.clip)),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 5.sp),
                    child: pw.FittedBox(
                        child: pw.Text('المتجر',
                            textAlign: pw.TextAlign.start,
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(
                                font: ttf,
                                fontSize: 4,
                                fontWeight: pw.FontWeight.normal),
                            overflow: pw.TextOverflow.clip)),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 5.sp),
                    child: pw.FittedBox(
                        child: pw.Text(
                      "المادة",
                      textAlign: pw.TextAlign.start,
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(
                          font: ttf,
                          fontSize: 4,
                          fontWeight: pw.FontWeight.normal),
                    )),
                  ),
                ]),
            pw.Divider(thickness: 0.5.sp, height: 2.5.sp),
            ...order.items!
                .map(
                  (e) => pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.symmetric(horizontal: 5.sp),
                          child: pw.FittedBox(
                            child: pw.Text(
                              '${e.totalPrice}',
                              textAlign: pw.TextAlign.start,
                              textDirection: pw.TextDirection.rtl,
                              style: pw.TextStyle(
                                  font: ttf,
                                  fontSize: 4,
                                  fontWeight: pw.FontWeight.normal),
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.symmetric(horizontal: 5.sp),
                          child: pw.FittedBox(
                              child: pw.Text('${e.quantity}',
                                  textAlign: pw.TextAlign.start,
                                  textDirection: pw.TextDirection.rtl,
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 4,
                                      fontWeight: pw.FontWeight.normal),
                                  overflow: pw.TextOverflow.clip)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.symmetric(horizontal: 5.sp),
                          child: pw.FittedBox(
                              child: pw.Text('${e.store}',
                                  textAlign: pw.TextAlign.start,
                                  textDirection: pw.TextDirection.rtl,
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 4,
                                      fontWeight: pw.FontWeight.normal),
                                  overflow: pw.TextOverflow.clip)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.symmetric(horizontal: 5.sp),
                          child: pw.FittedBox(
                              child: pw.Text(
                            e.product?.name ?? '',
                            textAlign: pw.TextAlign.start,
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(
                                font: ttf,
                                fontSize: 4,
                                fontWeight: pw.FontWeight.normal),
                          )),
                        ),
                      ]),
                )
                .toList(),
            pw.Divider(thickness: 0.5.sp, height: 2.5.sp),
            pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    '${order.total}',
                    textAlign: pw.TextAlign.start,
                    textDirection: pw.TextDirection.rtl,
                    style: pw.TextStyle(
                        font: ttf,
                        fontSize: 5,
                        fontWeight: pw.FontWeight.normal),
                  ),
                  pw.Text(
                    'إجمالي الطلب :',
                    textAlign: pw.TextAlign.start,
                    textDirection: pw.TextDirection.rtl,
                    style: pw.TextStyle(
                        font: ttf,
                        fontSize: 5,
                        fontWeight: pw.FontWeight.normal),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    order.fare ?? '0',
                    textAlign: pw.TextAlign.start,
                    textDirection: pw.TextDirection.rtl,
                    style: pw.TextStyle(
                        font: ttf,
                        fontSize: 5,
                        fontWeight: pw.FontWeight.normal),
                  ),
                  pw.Text(
                    'اجور توصيل  :',
                    textAlign: pw.TextAlign.start,
                    textDirection: pw.TextDirection.rtl,
                    style: pw.TextStyle(
                        font: ttf,
                        fontSize: 5,
                        fontWeight: pw.FontWeight.normal),
                  ),
                ]),
            pw.Divider(thickness: 0.5.sp, height: 2.5.sp),
            pw.Wrap(children: [
              pw.SizedBox(
                width: Get.width,
                child: pw.Text(
                  "ملاحظات :   ${order.info??'_'}" ,
                  textAlign: pw.TextAlign.start,
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(
                      font: ttf, fontSize: 5, fontWeight: pw.FontWeight.normal),
                ),
              )
            ]),
            pw.Wrap(children: [
              pw.SizedBox(
                width: Get.width,
                child: pw.Text(
                  order.address?.name ?? "لايوجد عنوان الطلب ",
                  textAlign: pw.TextAlign.start,
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(
                      font: ttf, fontSize: 5, fontWeight: pw.FontWeight.normal),
                ),
              )
            ]),


          ]),
        )); // Center
      },
    ),
  );
  Get.bottomSheet(PdfPreview(build: (format) async {
    return await doc.save();
  }));
}
