import 'restaurant_detail.dart';

class AddReviewResult {
  bool error;
  String message;
  List<CustomerReview> customerReviews;

  AddReviewResult({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory AddReviewResult.fromJson(Map<String, dynamic> json) =>
      AddReviewResult(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
          json["customerReviews"].map((x) => CustomerReview.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "customerReviews":
    List<dynamic>.from(customerReviews.map((x) => x.toJson())),
  };
}