import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/services/preference_manger.dart';
import 'package:tasky_app/core/widgets/custom_svg_picture.dart';
import 'package:tasky_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_app/features/navigation/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  SizedBox(height: AppSizes.h16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSvgPicture.withColorFilter(
                        path: 'assets/images/logo.svg',
                        size: 42,
                      ),
                      SizedBox(width: AppSizes.w16),

                      Text(
                        'Tasky',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.h108),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome To Tasky',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(width: AppSizes.w8),

                      const CustomSvgPicture.withColorFilter(
                        path: 'assets/images/waving-hand.svg',
                        size: 28,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.h8),
                  Text(
                    'Your productivity journey starts here.',
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall?.copyWith(fontSize: AppSizes.sp16),
                  ),
                  SizedBox(height: AppSizes.h24),
                  const CustomSvgPicture.withColorFilter(
                    path: 'assets/images/welcome.svg',
                    size: 216,
                  ),
                  SizedBox(height: AppSizes.h28),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          controller: nameController,
                          hintText: 'e.g. Sarah Khalid',
                          title: 'Full Name',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "please Enter Your Full Name";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: AppSizes.h24),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              AppSizes.h40,
                            ),
                          ),
                          onPressed: () async {
                            if (_key.currentState?.validate() ?? false) {
                              PreferenceManger().setString(
                                StorageKey.userName,
                                nameController.value.text,
                              );

                              if (!context.mounted) return;
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const MainScreen();
                                  },
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('place enter  your full name '),
                                ),
                              );
                            }
                          },
                          child: const Text('Let’s Get Started'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
