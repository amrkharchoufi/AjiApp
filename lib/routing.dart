import 'package:ajiapp/services/accomodation_service/accomodation_view.dart';
import 'package:ajiapp/services/auth/CreatePassword_view.dart';
import 'package:ajiapp/services/auth/SignUp_view.dart';
import 'package:ajiapp/services/auth/forgotpassword_view.dart';
import 'package:ajiapp/services/auth/login_view.dart';
import 'package:ajiapp/services/common/ClientSpace.dart';
import 'package:ajiapp/services/common/Service_view.dart';
import 'package:ajiapp/services/common/available_soon.dart';
import 'package:ajiapp/services/common/homepage_view.dart';
import 'package:ajiapp/services/common/notification_view.dart';
import 'package:ajiapp/services/contacts_service/importantct_view.dart';
import 'package:ajiapp/services/e-sim_service/e-sim_view.dart';
import 'package:ajiapp/services/followyourteam_service/view/follow_your_team_view.dart';
import 'package:ajiapp/services/food_service/food_view.dart.dart';
import 'package:ajiapp/services/profile/profile_view.dart';
import 'package:ajiapp/services/tourisme_service/visit_morroco_view.dart';
import 'package:ajiapp/services/transport_service/transportation_view.dart';
import 'package:ajiapp/services/visa_service/visa_view.dart';
import 'package:get/get.dart';

List<GetPage> routes = [
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
      page: () => const HomePage(),
      
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
      page: () =>  FollowYourTeamView(),
    ),
    GetPage(
      name: Routes.CONTACTS,
      page: () => const ImportantctView(),
    ),
    GetPage(
      name: Routes.SOON,
      page: () => const AvailableSoon(),
    ),
  ];


abstract class Routes {
  // Auth routes
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const CREATE_PASSWORD = '/create-password';
  static const VERIFY_EMAIL = '/verify-email';

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
  static const CONTACTS = '/contacts';
  static const SOON = '/soon';
}