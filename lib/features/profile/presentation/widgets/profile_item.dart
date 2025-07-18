import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/config/themes/text_style.dart';

class ProfileItem extends StatefulWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.isNotification = false,
    this.onPressed,
  });
  final String title;
  final String subTitle;
  final IconData icon;
  final bool isNotification;
  final void Function()? onPressed;

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          CircleAvatar(
            // radius: 30,
            backgroundColor: ColorManager.primaryColor.withOpacity(0.1),
            child: Icon(
              widget.icon,
              size: 30,
              color: ColorManager.primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: getBoldStyle(fontSize: 14, color: Colors.black),
              ),
              Text(
                widget.subTitle,
                style: getRegularStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          if (widget.isNotification) ...{
            Switch(
              value: value,
              onChanged: (val) => setState(
                () => value = val,
              ),
              activeColor: ColorManager.primaryColor,
            ),
          } else ...{
            IconButton(
              onPressed: widget.onPressed,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16.sp,
              ),
            ),
          },
        ],
      ),
    );
  }
}
