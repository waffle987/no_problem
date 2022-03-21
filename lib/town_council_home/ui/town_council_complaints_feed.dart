import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_problem/config/assets.dart';
import 'package:no_problem/config/ui_helpers.dart';
import 'package:no_problem/general_widgets/progress_indicators.dart';
import 'package:no_problem/submit_complaint/models/complaint_model.dart';
import 'package:no_problem/town_council_home/controllers/town_council_complaint_feed_controller.dart';
import 'package:no_problem/town_council_home/ui/town_council_complaints_page.dart';
import 'package:timeago/timeago.dart' as timeago;

class TownCouncilComplaintsFeed extends StatelessWidget {
  const TownCouncilComplaintsFeed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);

    /// GetX controllers
    final TownCouncilFeedController _townCouncilFeedController =
        Get.put<TownCouncilFeedController>(TownCouncilFeedController());

    return Obx(
      () => _townCouncilFeedController.complaints.value != null
          ? _townCouncilFeedController.complaints.value!.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      _townCouncilFeedController.complaints.value!.length,
                  itemBuilder: (_, index) {
                    ComplaintModel complaintModel =
                        _townCouncilFeedController.complaints.value![index];

                    return GestureDetector(
                      onTap: () => Get.to(() => TownCouncilComplaintsPage(
                          complaintModel: complaintModel)),
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
