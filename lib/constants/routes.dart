class Routes {
  static const String login = '/login';
  static const String signup = '/signup'; // Ensure this is defined
  static const String roleSelection = '/role-selection';

  // Traveler routes
  static const String travelerHome = '/traveler/home';
  static const String createRide = '/traveler/create-ride';
  static const String activeRide = '/traveler/active-ride';
  static const String shareAudit = '/traveler/share-audit';

  // Companion routes
  static const String companionHome = '/companion/home';
  static const String trackRide = '/companion/track';
  static const String feedback = '/companion/feedback';

  // Admin routes
  static const String adminDashboard = '/admin/dashboard';
  static const String rideDetail = '/admin/ride-detail';
}
