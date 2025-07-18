import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/core/utils/functions/extensions.dart';
import 'package:parky/core/utils/widgets/upload_file/upload_file_widget.dart';

import '../../../../config/themes/text_style.dart';
import '../custom_text.dart';

class UploadFileTitleAndNote extends StatelessWidget {
  const UploadFileTitleAndNote({
    super.key,
    required this.params,
  });

  final UploadFileParams params;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        CustomText(
          text: params.title,
          style: getRegularStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.h),
        if (params.isEmpty) ...[
          CustomText(
            text: "JPG, PNG or PDF, file size no more than 10MB",
            style: getRegularStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],

        if (params.isEmpty == false) ...[
          Text(
            _fileName,
            style: getRegularStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ],
    );
  }

  String get _fileName {
    if (params.file.validSize) {
      return params.file!.path.split('/').last;
    } else {
      return params.fileUrl!.split('/').last;
    }
  }
}
