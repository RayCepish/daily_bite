import 'package:google_sign_in/google_sign_in.dart';

class UserModel {
  final String id;
  final String? name;
  final String email;
  final String? imageUrl;
  // final NutritionModel? nutritionModel;
  UserModel({
    required this.id,
    this.name,
    required this.email,
    this.imageUrl,
    // this.nutritionModel,
  });

  factory UserModel.fromGoogleAccount(GoogleSignInAccount account) {
    return UserModel(
      id: account.id,
      name: account.displayName ?? '',
      email: account.email,
      imageUrl: account.photoUrl,
      // nutritionModel: const NutritionModel(
      //   protein: 0,
      //   fat: 0,
      //   carbs: 0,
      //   calories: 0,
      // ),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'],
      imageUrl: json['photo'],
      // nutritionModel: json['nutritionModel'] != null
      //     ? NutritionModel.fromJson(
      //         json['nutritionModel'],
      //       )
      //     : const NutritionModel(
      //         protein: 0,
      //         fat: 0,
      //         carbs: 0,
      //         calories: 0,
      //       ),
    );
  }
}
