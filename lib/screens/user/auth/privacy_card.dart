import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_body_parts/utils/app_string.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';
import 'package:flutter_body_parts/utils/open_url.dart';

class PrivacyCard extends StatelessWidget {
  const PrivacyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(style: AppStyles.textStyle14(), children: [
          const TextSpan(
              text: 'by Continue with Email you are agree with out '),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => openUrl(AppString.termsUrl),
            text: 'Terms & Conditions',
            style: AppStyles.textStyle(color: Colors.blue)
                .copyWith(decoration: TextDecoration.underline),
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => openUrl(AppString.privayUrl),
            text: 'Privacy Policy',
            style: AppStyles.textStyle(color: Colors.blue)
                .copyWith(decoration: TextDecoration.underline),
          ),
        ]),
      ),
    );
  }
}
