import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_problem/authentication/models/town_council_model.dart';

import '../models/mediator_model.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  /// Text Editing Controllers
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  final TextEditingController otpTextEditingController =
      TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController bioTextController = TextEditingController();
  final TextEditingController emojiTextController = TextEditingController();

  /// Firebase instances
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  /// Stored values
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<TownCouncilModel> firestoreTownCouncil = Rxn<TownCouncilModel>();
  Rxn<MediatorModel> firestoreMediator = Rxn<MediatorModel>();
  RxBool isPasswordVisible = RxBool(true);
  RxBool isNewUser = RxBool(false);
  RxBool isLoading = RxBool(false);

  @override
  void onReady() async {
    super.onReady();

    /// Run every time auth state changes
    ever(firebaseUser, handleAuthChanged);

    firebaseUser.bindStream(user);
  }

  @override
  void onClose() {
    super.onClose();

    emailTextController.dispose();
    passwordTextController.dispose();
    usernameTextController.dispose();
  }

  void handleAuthChanged(_firebaseUser) async {
    if (_firebaseUser?.uid != null) {
      firestoreTownCouncil.bindStream(streamFirestoreTownCouncil());

      firestoreMediator.bindStream(streamFirestoreMediator());

      Get.offAll(() => Scaffold());
    } else {
      Get.offAll(() => Scaffold());
    }
  }

  /// Firebase user one-time fetch
  Future<User> get getUser async => _firebaseAuth.currentUser!;

  /// Firebase user a real time stream
  Stream<User?> get user => _firebaseAuth.authStateChanges();

  /// Streams the firestore TOWN COUNCIL from the firestore collection
  Stream<TownCouncilModel?> streamFirestoreTownCouncil() {
    return _firebaseFirestore
        .collection("townCouncils")
        .doc(firebaseUser.value!.uid)
        .snapshots()
        .map((snapshot) => snapshot.data() == null
            ? null
            : TownCouncilModel.fromData(snapshot.data()!));
  }

  /// Streams the firestore MEDIATOR from the firestore collection
  Stream<MediatorModel?> streamFirestoreMediator() {
    return _firebaseFirestore
        .collection("mediators")
        .doc(firebaseUser.value!.uid)
        .snapshots()
        .map((snapshot) => snapshot.data() == null
            ? null
            : MediatorModel.fromData(snapshot.data()!));
  }

  /// Updates the Firestore TOWN COUNCIL in users collection
  void updateTownCouncilFirestore({required TownCouncilModel townCouncil}) {
    _firebaseFirestore
        .collection("townCouncils")
        .doc(firebaseUser.value!.uid)
        .update(townCouncil.data(townCouncil: townCouncil));
    update();
  }

  /// Updates the Firestore MEDIATOR in merchants collection
  void updateMediatorFirestore({required MediatorModel mediatorModel}) {
    _firebaseFirestore
        .collection("mediators")
        .doc(firebaseUser.value!.uid)
        .update(mediatorModel.data(mediator: mediatorModel));
    update();
  }

  /// Create the firestore USER in users collection
  void _createUserFirestore(UserModel user, User _firebaseUser) {
    _firebaseFirestore
        .collection("users")
        .doc(_firebaseUser.uid)
        .set(user.toJson());
    update();
  }

  /// Create the firestore MERCHANT in users collection
  void _createMerchantFirestore(MerchantModel merchant, User _firebaseUser) {
    _firebaseFirestore
        .collection("merchants")
        .doc(_firebaseUser.uid)
        .set(merchant.toJson());
    update();
  }

  void signInWithPhoneNumber() async {
    /// Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpTextEditingController.text,
    );

    /// Sign the user in (or link) with the credential
    await _firebaseAuth.signInWithCredential(credential).then((result) async {
      isLoading.value = false;

      if (result.additionalUserInfo!.isNewUser) {
        final String link = await _dynamicLinkService.createProfileLink(
          id: result.user!.uid,
          userType: 'user',
        );

        isNewUser.value = true;

        /// Create the new USER object
        UserModel _newUser = UserModel(
          id: result.user!.uid,
          phoneNumber: result.user!.phoneNumber!,
          username: 'Zap User',
          photoUrl: '',
          bio: bioTextController.text,
          profileUrl: link,
          tag: '',
        );

        /// Create the USER in Firestore
        _createUserFirestore(_newUser, result.user!);

        /// Clear Text Editing Controllers
        phoneTextEditingController.clear();
        otpTextEditingController.clear();
      }
    });
  }

  /// Method to handle user sign in using phone (USER)
  void verifyPhoneNumber() async {
    isLoading.value = true;

    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+65${phoneTextEditingController.text}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth
              .signInWithCredential(credential)
              .then((result) async {
            isLoading.value = false;

            if (result.additionalUserInfo!.isNewUser) {
              isNewUser.value = true;

              final String link = await _dynamicLinkService.createProfileLink(
                id: result.user!.uid,
                userType: 'user',
              );

              /// Create the new USER object
              UserModel _newUser = UserModel(
                id: result.user!.uid,
                phoneNumber: result.user!.phoneNumber!,
                username: 'Zap User',
                photoUrl: '',
                bio: bioTextController.text,
                profileUrl: link,
                tag: '',
              );

              /// Create the USER in Firestore
              _createUserFirestore(_newUser, result.user!);

              /// Clear Text Editing Controllers
              phoneTextEditingController.clear();
              otpTextEditingController.clear();
            }
          });
        },
        codeAutoRetrievalTimeout: (String _verificationId) {
          verificationId = _verificationId;
        },
        verificationFailed: (FirebaseAuthException exception) {
          if (exception.code == 'invalid-phone-number') {
            Get.snackbar(
              'Invalid phone number!'.tr,
              "Please use a valid phone number",
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 10),
              backgroundColor: Colors.red,
              colorText: Get.theme.snackBarTheme.actionTextColor,
            );
          } else {
            print(exception);

            Get.snackbar(
              'Error!'.tr,
              exception.code,
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 10),
              backgroundColor: Colors.red,
              colorText: Get.theme.snackBarTheme.actionTextColor,
            );
          }
        },
        codeSent: (String _verificationId, int? resendToken) {
          verificationId = _verificationId;

          Get.to(() => OTPPage());
        },
      );
    } catch (error) {
      Get.snackbar(
        'Sign up error'.tr,
        "$error",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 10),
        backgroundColor: Colors.red,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }

  /// Method to handle user sign in using email and password (MERCHANT)
  void signInWithEmailAndPassword(BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailTextController.text.trim(),
          password: passwordTextController.text.trim());
      emailTextController.clear();
      passwordTextController.clear();
    } catch (error) {
      Get.snackbar(
        'Incorrect Email or Password'.tr,
        'The email or password you entered is incorrect. Please try again.'.tr,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 7),
        backgroundColor: Colors.red,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }

  /// User registration using email and password (MERCHANT)
  void registerWithEmailAndPassword(BuildContext context) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      )
          .then((result) async {
        print('uID: ' + result.user!.uid.toString());
        print('email: ' + result.user!.email.toString());

        final String link = await _dynamicLinkService.createProfileLink(
          id: result.user!.uid,
          userType: 'merchant',
        );

        /// Create the new MERCHANT object
        MerchantModel _newMerchant = MerchantModel(
          id: result.user!.uid,
          email: result.user!.email!,
          username: usernameTextController.text,
          photoUrl: '',
          bio: bioTextController.text,
          profileUrl: link,
          tag: '',
          verified: false,
          emoji: emojiTextController.text,
        );

        /// Create the MERCHANT in Firestore
        _createMerchantFirestore(_newMerchant, result.user!);

        /// Clear Text Editing Controllers
        emailTextController.clear();
        passwordTextController.clear();
        usernameTextController.clear();
        bioTextController.clear();
        emojiTextController.clear();
      });
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
        'Sign up error'.tr,
        error.message!,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 10),
        backgroundColor: Colors.red,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }

  /// Password reset email
  Future<void> sendPasswordResetEmail(BuildContext context) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
          email: emailTextController.text);
      Get.snackbar(
        'auth.resetPasswordNoticeTitle'.tr,
        'auth.resetPasswordNotice'.tr,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
        'auth.resetPasswordFailed'.tr,
        error.message!,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 10),
        backgroundColor: Colors.red,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }

  /// Sign out
  Future<void> signOut() {
    /// Clear Text Editing Controllers
    emailTextController.clear();
    passwordTextController.clear();
    usernameTextController.clear();
    bioTextController.clear();
    phoneTextEditingController.clear();
    otpTextEditingController.clear();

    /// Reset location ID value (For Staff accounts)
    locationId.value = '';

    /// Reset Firestore USER and MERCHANT value
    firestoreUser.value = null;
    firestoreMerchant.value = null;

    return _firebaseAuth.signOut();
  }

  Future<bool> checkIfUsernameExists({required String username}) async {
    QuerySnapshot userDoc = await _firebaseFirestore
        .collection("users")
        .where("username", isEqualTo: username)
        .get();

    return userDoc.docs.isNotEmpty;
  }
}
