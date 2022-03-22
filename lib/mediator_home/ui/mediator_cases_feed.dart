import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_problem/config/assets.dart';
import 'package:no_problem/config/ui_helpers.dart';
import 'package:no_problem/general_widgets/progress_indicators.dart';
import 'package:no_problem/mediator_home/controllers/mediator_case_feed_controller.dart';
import 'package:no_problem/mediator_home/ui/mediator_case_page.dart';
import 'package:no_problem/submit_complaint/models/complaint_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class MediatorCasesFeed extends StatelessWidget {
  const MediatorCasesFeed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);

    /// GetX controllers
    final MediatorCaseFeedController _mediatorCaseFeedController =
        Get.put<MediatorCaseFeedController>(MediatorCaseFeedController());

    return Obx(
      () => _mediatorCaseFeedController.cases.value != null
          ? _mediatorCaseFeedController.cases.value!.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _mediatorCaseFeedController.cases.value!.length,
                  itemBuilder: (_, index) {
                    ComplaintModel complaintModel =
                        _mediatorCaseFeedController.cases.value![index];

                    return GestureDetector(
                      onTap: () => Get.to(() =>
                          MediatorCasePage(complaintModel: complaintModel)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: _mediaQuery.size.height * 0.02),
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: kPrimaryColour,
                                child: Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kSecondaryColour,
                                  ),
                                ),
                              ),
                              title: Text(
                                complaintModel.name,
                              ),
                              subtitle: Text(complaintModel.description),
                              trailing: Text(
                                timeago
                                    .format(complaintModel.timestamp.toDate()),
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : ListView(
                  children: [
                    Image.asset(Assets.complaintsSplashPage),
                  ],
                )
          : Center(child: circularProgressIndicator(context: context)),
    );
  }
}
