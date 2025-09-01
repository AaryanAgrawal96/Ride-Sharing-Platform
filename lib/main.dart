import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ride_tracking_platform/firebase_options.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/role_selection_page.dart';
import 'pages/auth/signup_page.dart';
import 'pages/traveler/traveler_home.dart';
import 'pages/traveler/create_ride_page.dart';
import 'pages/traveler/active_ride_page.dart';
import 'pages/traveler/share_audit_page.dart';
import 'pages/companion/companion_home.dart';
import 'pages/companion/track_ride_page.dart';
import 'pages/companion/feedback_page.dart';
import 'pages/admin/admin_dashboard.dart';
import 'pages/admin/ride_detail_page.dart';
import 'constants/routes.dart';
import 'models/ride.dart'; // Import the Ride model

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride Tracking Platform',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          secondary: Colors.amber,
        ),
      ),
      initialRoute: Routes.roleSelection,
      routes: {
        Routes.login: (context) => const LoginPage(),
        Routes.signup: (context) => const SignupPage(),
        '/role-selection': (context) => const RoleSelectionPage(),
        '/traveler/home': (context) => TravelerHome(
          travelerId: 'exampleTravelerId',
        ), // Ensure this matches Firestore data
        '/traveler/create-ride': (context) => const CreateRidePage(),
        '/traveler/active-ride': (context) {
          final ride =
              ModalRoute.of(context)!.settings.arguments
                  as Ride; // Ride is now recognized
          return ActiveRidePage(ride: ride);
        },
        '/traveler/share-audit': (context) => const ShareAuditPage(),
        '/companion/home': (context) => const CompanionHome(),
        '/companion/track': (context) => const TrackRidePage(),
        '/companion/feedback': (context) => const FeedbackPage(),
        '/admin/dashboard': (context) => const AdminDashboard(),
        '/admin/ride-detail': (context) => const RideDetailPage(),
      },
    );
  }
}
