import 'package:flutter/material.dart';
import 'package:no_problem/config/ui_helpers.dart';
import 'package:no_problem/general_widgets/buttons/elongated_button.dart';
import 'package:no_problem/general_widgets/centred_view.dart';
import 'package:no_problem/submit_complaint/models/complaint_model.dart';

class TownCouncilComplaintsPage extends StatelessWidget {
  final ComplaintModel complaintModel;

  const TownCouncilComplaintsPage({
    Key? key,
    required this.complaintModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);
    final MediaQueryData _mediaQuery = MediaQuery.of(context);

    Widget _buildSection({
      required String title,
      required String subtitle,
    }) {
      return Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 15.0),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _themeData.scaffoldBackgroundColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: CenteredView(
        child: ListView(
          shrinkWrap: true,
          children: [
            _buildSection(
              title: "Name",
              subtitle: complaintModel.name,
            ),
            SizedBox(height: _mediaQuery.size.height * 0.02),
            _buildSection(
              title: "Complainant's Phone Number",
              subtitle: complaintModel.phoneNumber,
            ),
            SizedBox(height: _mediaQuery.size.height * 0.02),
            _buildSection(
              title: "Number of Parties",
              subtitle: complaintModel.numberOfParties,
            ),
            SizedBox(height: _mediaQuery.size.height * 0.02),
            _buildSection(
              title: "Name of Other Parties",
              subtitle: complaintModel.nameOfParties,
            ),
            SizedBox(height: _mediaQuery.size.height * 0.02),
            _buildSection(
              title: "Case Description",
              subtitle: complaintModel.description,
            ),
            SizedBox(height: _mediaQuery.size.height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _mediaQuery.size.width * 0.3),
              child: ElongatedButton(
                text: "Send for Mediation",
                onPressed: () {},
                buttonColour: kPrimaryColour,
                textColour: kSecondaryColour,
              ),
            ),
            SizedBox(height: _mediaQuery.size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _mediaQuery.size.width * 0.3),
              child: ElongatedButton(
                text: "Dismiss Complaint",
                onPressed: () {},
                buttonColour: Colors.red,
                textColour: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
