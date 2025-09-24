import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/views/torunament_view/tournamnet_vm.dart';

class TournamentView extends StatelessWidget {
  const TournamentView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.fetchData(),
      fireOnViewModelReadyOnce: true,
      viewModelBuilder: () => TournamentVM(),
      builder: (context, viewModel, child) {
        return viewModel.isBusy
            ? const Scaffold(
                backgroundColor: Color.fromARGB(255, 58, 57, 57),
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: const Color.fromARGB(255, 58, 57, 57),
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text('Tournament',
                      style: TextStyle(color: Colors.white)),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        NavigationService().navigateToSettingView();
                      },
                    ),
                    // IconButton(
                    //   icon: const Icon(
                    //     Icons.logout,
                    //     color: Colors.white,
                    //   ),
                    //   onPressed: () async {
                    //     await GoogleSignIn().signOut();
                    //     await FirebaseAuth.instance.signOut();

                    //     final prefs = await SharedPreferences.getInstance();
                    //     prefs.remove('googleUserId');
                    //     prefs.setBool("isloggedIn", false);
                    //     NavigationService().replaceWithLoginView();
                    //   },
                    // ),
                  ],
                ),
                body: SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        viewModel.userService.allTournamentsData?.length == 0
                            ? Text(
                                'No tournaments available',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: viewModel.userService
                                          .allTournamentsData?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    final tournament = viewModel
                                        .userService.allTournamentsData![index];
                                    return GestureDetector(
                                      onTap: () {
                                        NavigationService()
                                            .navigateToTournamentOptionView(
                                                tournamentName: tournament[
                                                    'tournamentName'],
                                                originalTitle: viewModel
                                                        .userService
                                                        .allTournamentsName![
                                                    index]['tournamentName'],
                                                index: index,
                                                tournamentData: tournament);
                                      },
                                      child: tournamentCard(
                                          tournament['tournamentName'],
                                          viewModel.getElapsedFromTimestamp(
                                              tournament['LastUpdated']),
                                          tournament),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (viewModel.showMenu) ...[
                      _buildMenuButton(
                        label: 'Create New Tournament',
                        icon: Icons.emoji_events,
                        color: const Color(0xffFF7F27),
                        onTap: () {
                          NavigationService().navigateToNewTournamentView();
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildMenuButton(
                        label: 'Home',
                        icon: Icons.home,
                        color: const Color(0xffFF7F27),
                        onTap: () {
                          NavigationService().replaceWithHomeView();
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: viewModel.onTap,
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

Widget _buildMenuButton({
  required String label,
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(label, style: const TextStyle(fontSize: 14)),
      ),
      const SizedBox(width: 8),
      FloatingActionButton(
        heroTag: label,
        mini: true,
        backgroundColor: color,
        onPressed: onTap,
        child: Icon(icon, color: Colors.white),
      ),
    ],
  );
}

Widget tournamentCard(name, time, tournamentData) {
  final user = FirebaseAuth.instance.currentUser;
  return Container(
    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
    margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4.r,
          offset: Offset(0, 2.h),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Trophy icon
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: Image.asset(
            'assets/AKL-BALL.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12.w),
        // Text area
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              // SizedBox(height: 4.h),
              // Text(
              //   'Users: 0',
              //   style: GoogleFonts.poppins(
              //     fontSize: 14.sp,
              //     color: Colors.black87,
              //   ),
              // ),
            ],
          ),
        ),
        // Duration and admin label
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time.toString(),
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
              margin: EdgeInsets.only(top: 4.h),
              decoration: BoxDecoration(
                color: Color(0xFFFF7F27),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: tournamentData['adminUid'] == user!.uid
                  ? Text(
                      'ADMIN',
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'PARTICIPANT',
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ],
        ),
      ],
    ),
  );
}
