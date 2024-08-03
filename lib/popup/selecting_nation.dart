
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../api_service/response/role_lg_nt_response.dart';
import '../color_font_util.dart';

class SelectingNation extends StatelessWidget {
  const SelectingNation({super.key, required this.onTap, required this.data});

  final Function(String value, int id) onTap;
  final List<Nation> data;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      maxChildSize: 1,
      minChildSize: 0.25,
      builder: (context, s) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Nationality', style: TextStyle(
                      fontFamily: ColorFontUtil.poppins,
                      color: ColorFontUtil.black25,
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                  ),),
                  IconButton(onPressed: () {
                    Get.back();
                  },icon: Icon(Icons.cancel), color: ColorFontUtil.red02,)
                ],
              ),
              SizedBox(height: 8,),
              Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            onTap.call(data[index].nationality, data[index].id);
                            Get.back();
                          },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          padding: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                              border: Border(bottom:BorderSide(color: ColorFontUtil.redF5))
                          ),
                          child: Text(data[index].nationality, style: TextStyle(
                              fontFamily: ColorFontUtil.poppins,
                              color: ColorFontUtil.black25
                          ),),
                        ),
                      );
                    }),
              )
            ],
          ),
        );
      },
    );
  }
}
