import 'package:in_app_review/in_app_review.dart';

class ReviewPrompt {
  const ReviewPrompt._();

  static Future<void> executeAfterSuccess() async {
    final InAppReview review = InAppReview.instance;
    if (!await review.isAvailable()) {
      return;
    }
    await review.requestReview();
  }
}
