import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:tournament_manager/views/participant/edit_particpant_view/edit_participant_vm.dart';

class EditParticipantView extends StatelessWidget {
  final String tournamentName;
  final String participantName;

  const EditParticipantView(
      {super.key, required this.tournamentName, required this.participantName});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EditParticipantVM(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 58, 57, 57),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text('Participant Details',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                )),
          ),
          body: FutureBuilder(
            future: viewModel.getParticipantDetails(
                tournamentName, participantName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final participantData = snapshot.data;
              return Center(
                child: Column(
                  children: [
                    40.verticalSpace,
                    CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.blue,
                      child: participantData!['imageUrl'] == ""
                          ? Icon(Icons.person, color: Colors.white, size: 50.sp)
                          : ClipOval(
                              child: Image.network(
                                participantData['imageUrl'],
                                width: 100.w,
                                height: 100.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    20.verticalSpace,
                    Text(
                      '${participantData['name']}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    40.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: ElevatedButton(
                        onPressed: () {
                          viewModel.deleteParticipant(
                              tournamentName, participantName);
                          Navigator.pop(context); // Go back after deletion
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: Text(
                          'Delete Participant',
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
