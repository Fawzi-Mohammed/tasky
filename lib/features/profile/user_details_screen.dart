import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/services/preference_manger.dart';
import 'package:tasky_app/core/widgets/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
  final String userName;
  final String motivationQuote;
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final TextEditingController userNameController;
  late final TextEditingController motivationQuoteController;
  final GlobalKey<FormState> userDetailsFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.userName);
    motivationQuoteController = TextEditingController(
      text: widget.motivationQuote,
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    motivationQuoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.pw16,
            vertical: AppSizes.ph8,
          ),
          child: Form(
            key: userDetailsFormKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: userNameController,
                          hintText: 'Fawzi Mohammed',
                          title: 'User Name',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a user name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: AppSizes.ph20),
                        CustomTextFormField(
                          controller: motivationQuoteController,
                          hintText: 'One task at a time. One step closer.',
                          title: 'Motivation Quote',
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (userDetailsFormKey.currentState?.validate() ??
                          false) {
                        await PreferenceManger().setString(
                          StorageKey.userName,
                          userNameController.text.trim(),
                        );
                        await PreferenceManger().setString(
                          StorageKey.motivationQuote,
                          motivationQuoteController.text.trim(),
                        );
                        if (!context.mounted) return;
                        Navigator.pop(context, true);
                      }
                    },

                    child: Text('Save Changes'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
