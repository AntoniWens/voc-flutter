
import 'package:flutter/cupertino.dart';
import '../api_service/model/user_m.dart';
import '../color_font_util.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.data});

  final UserM data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8,bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset('assets/images/user.png', width: 50,height: 50,fit: BoxFit.fill,)
          ),
          const SizedBox(width: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.fullName, style: TextStyle(
                  fontFamily: ColorFontUtil.poppins,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
              ),),
              const SizedBox(height: 4,),
              Text('Role : ${data.role}', style: TextStyle(
                  fontFamily: ColorFontUtil.poppins,
                  fontSize: 14,
                  color: ColorFontUtil.black25.withOpacity(0.8),
                  fontWeight: FontWeight.w400
              ),),
            ],
          ),
        ],
      ),
    );
  }
}
