import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/config/themes/text_style.dart';
import 'package:parky/core/utils/widgets/custom_alert_dialog.dart';
import 'package:parky/core/utils/widgets/custom_elevated_button.dart';
import 'package:parky/core/utils/widgets/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/notification_model.dart';
import '../cubit/notifications_cubit.dart';
import '../widgets/no_notifications_widget.dart';
import '../widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit()..getNotifications(),
      child: Builder(builder: (context) {
        return BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            List<NotificationModel>? notifications =
                NotificationsCubit.get(context).notifications;

            if (state is NotificationError) {
              return Scaffold(
                backgroundColor: ColorManager.primaryColor,
                body: Center(
                  child: Text(state.message),
                ),
              );
            }
            return Scaffold(
              backgroundColor: ColorManager.primaryColor,
              body: Column(
                children: [
                  // app bar
                  SizedBox(
                    height: 0.17.sh,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        CustomText(
                          text: "Notifications",
                          style:
                              getBoldStyle(fontSize: 18, color: Colors.white),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // dilog
                            showCustomAlertDialog(
                              context: context,
                              title: "Delete All Notifications",
                              content: Column(
                                children: [
                                  const Text(
                                      "Are you sure you want to delete?"),
                                  SizedBox(
                                    height: 10.w,
                                  ),
                                  SizedBox(
                                    height: 40.h,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CustomElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            text: 'cancle',
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: CustomElevatedButton(
                                            onPressed: () {
                                              NotificationsCubit.get(context)
                                                  .deleteAllNotifications();
                                              Navigator.pop(context);
                                            },
                                            text: 'delete',
                                            backgroundColor: Colors.red,
                                            borderColor: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (notifications?.isEmpty ?? false) ...{
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.all(16.r),
                        child: const NoNotificationsWidget(),
                      ),
                    )
                  } else ...{
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.all(16.r),
                        // child: NoNotificationsWidget(),
                        child: Skeletonizer(
                          enabled: state is NotificationsLoading,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return NotificationItem(
                                notificationModel: notifications?[index],
                              );
                            },
                            itemCount: notifications?.length ?? 2,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                  },
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
