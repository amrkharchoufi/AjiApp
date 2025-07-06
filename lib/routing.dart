// ignore_for_file: constant_identifier_names

import 'package:ajiapp/services/accomodation_service/view/accomodation_view.dart';
import 'package:ajiapp/services/auth/common/CreatePassword_view.dart';
import 'package:ajiapp/services/auth/common/SignUp_view.dart';
import 'package:ajiapp/services/auth/common/changeEmail_view.dart';
import 'package:ajiapp/services/auth/common/forgotpassword_view.dart';
import 'package:ajiapp/services/auth/common/login_view.dart';
import 'package:ajiapp/services/common/ClientSpace.dart';
import 'package:ajiapp/services/common/Service_view.dart';
import 'package:ajiapp/services/common/available_soon.dart';
import 'package:ajiapp/services/followyourteam_service/view/stadium_details_view.dart';
import 'package:ajiapp/services/followyourteam_service/view/team_details_view.dart';
import 'package:ajiapp/services/common/notification_view.dart';
import 'package:ajiapp/services/contacts_service/importantct_view.dart';
import 'package:ajiapp/services/e-sim_service/view/e-sim_view.dart';
import 'package:ajiapp/services/followyourteam_service/view/follow_your_team_view.dart';
import 'package:ajiapp/services/food_service/food_view.dart.dart';
import 'package:ajiapp/services/onboarding/view/onboarding_view.dart';
import 'package:ajiapp/services/profile/view/edit_profile_view.dart';
import 'package:ajiapp/services/profile/view/profile_view.dart';
import 'package:ajiapp/services/splash/view/splash_view.dart';
import 'package:ajiapp/services/ticket_service/view/ticket_view.dart';
import 'package:ajiapp/services/tourisme_service/view/visit_morroco_view.dart';
import 'package:ajiapp/services/transport_service/transportation_view.dart';
import 'package:ajiapp/services/visa_service/view/visa_view.dart';
import 'package:ajiapp/services/visa_service/view/with_visa.dart';
import 'package:ajiapp/services/visa_service/view/without_visa_view.dart';
import 'package:get/get.dart';

import 'services/map_service/view/Map_view.dart';

List<GetPage> routes = [
  GetPage(
    name: Routes.SPLASH,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: Routes.ONBOARDING,
    page: () => OnboardingView(),
  ),
  // Auth routes
  GetPage(
    name: Routes.LOGIN,
    page: () => const LoginView(),
  ),
  GetPage(
    name: Routes.SIGNUP,
    page: () => const SignupView(),
  ),
  GetPage(
    name: Routes.FORGOT_PASSWORD,
    page: () => const ForgotpasswordView(),
  ),
  GetPage(
    name: Routes.CREATE_PASSWORD,
    page: () => const CreatepasswordView(),
  ),
  // GetPage(
  //   name: Routes.VERIFY_EMAIL,
  //   page: () => const VerifyemailView(),

  // ),

  // Client space routes
  GetPage(
    name: Routes.CLIENT_SPACE,
    page: () => const Clientspace(),
  ),

  // Home routes
  GetPage(
    name: Routes.HOME,
    page: () => const Clientspace(),
  ),

  // Services routes
  GetPage(
    name: Routes.SERVICES,
    page: () => const ServiceView(),
  ),

  // Accommodation routes
  GetPage(
    name: Routes.ACCOMMODATION,
    page: () => const AccomodationView(),
  ),

  // eSIM routes
  GetPage(
    name: Routes.ESIM,
    page: () => const EsimView(),
  ),

  // Transportation routes
  GetPage(
    name: Routes.TRANSPORTATION,
    page: () => const Transportationview(),
  ),

  // Visa routes
  GetPage(
    name: Routes.VISA,
    page: () => const VisaView(),
  ),
  GetPage(
    name: Routes.WITH_VISA,
    page: () => const WithVisa(),
  ),
  GetPage(
    name: Routes.WITHOUT_VISA,
    page: () => const WithoutVisaView(),
  ),

  // Visit Morocco routes
  GetPage(
    name: Routes.VISIT_MOROCCO,
    page: () => const VisitMorrocoView(),
  ),

  // Food routes
  GetPage(
    name: Routes.FOOD,
    page: () => const FoodHomePage(),
  ),

  // Profile routes
  GetPage(
    name: Routes.PROFILE,
    page: () => const ProfileView(),
  ),

  // Notification routes
  GetPage(
    name: Routes.NOTIFICATION,
    page: () => const NotificationView(),
  ),
  GetPage(
    name: Routes.FOLLOWYOURTEAM,
    page: () => FollowYourTeamView(),
  ),
  GetPage(
    name: Routes.TEAM_DETAILS,
    page: () => const TeamDetailsView(),
  ),
  GetPage(
    name: Routes.CONTACTS,
    page: () => const ImportantctView(),
  ),
  GetPage(
    name: Routes.SOON,
    page: () => const AvailableSoon(),
  ),
  GetPage(
    name: Routes.TICKETS,
    page: () => const TicketView(),
  ),
  GetPage(
    name: Routes.MAP,
    page: () => MapView(),
  ),
  GetPage(name: Routes.STADIUM_DETAILS, page: () => StadiumDetailsView()),
  GetPage(name: Routes.CHANGE_EMAIL, page: () => ChangeemailView()),
  GetPage(name: Routes.EDIT_PROFILE, page: () => EditProfileView())
];

abstract class Routes {
  // Onboarding and splash routes
  static const SPLASH = '/splash';
  static const SPLASH1 = '/splash1';
  static const ONBOARDING = '/onboarding';

  // Auth routes
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const CREATE_PASSWORD = '/create-password';
  static const VERIFY_EMAIL = '/verify-email';
  static const CHANGE_EMAIL = '/change-email';
  static const EDIT_PROFILE = '/edit-profile';

  // App routes
  static const CLIENT_SPACE = '/client-space';
  static const HOME = '/home';
  static const SERVICES = '/services';

  // Service specific routes
  static const ACCOMMODATION = '/accommodation';
  static const ESIM = '/esim';
  static const TRANSPORTATION = '/transportation';
  static const VISA = '/visa';
  static const WITH_VISA = '/with-visa';
  static const WITHOUT_VISA = '/without-visa';
  static const VISIT_MOROCCO = '/visit-morocco';
  static const FOOD = '/food';

  // User routes
  static const PROFILE = '/profile';
  static const NOTIFICATION = '/notification';

  // Visit Morocco sub-routes
  static const DISCOVER = '/discover';
  static const COMING_UP = '/coming-up';

  static const FOLLOWYOURTEAM = '/follow-your-team';
  static const TEAM_DETAILS = '/team-details';
  static const STADIUM_DETAILS = '/stadium-details';
  static const CONTACTS = '/contacts';
  static const SOON = '/soon';
  static const TICKETS = '/tickets';
  static const MAP = '/map';
}
