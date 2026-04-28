import 'package:flutter/material.dart';
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
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomSvgPicture.withColorFilter(
                        path: 'assets/images/logo.svg',
                        size: 42,
                      ),
                      const SizedBox(width: 16),

                      Text(
                        'Tasky',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 108),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome To Tasky',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(width: 8),

                      const CustomSvgPicture.withColorFilter(
                        path: 'assets/images/waving-hand.svg',
                        size: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your productivity journey starts here.',
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall?.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  const CustomSvgPicture.withColorFilter(
                    path: 'assets/images/welcome.svg',
                    size: 216,
                  ),
                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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

                        const SizedBox(height: 24),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF15B86C),
                            foregroundColor: Color(0xFFFFFCFC),
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              40,
                            ),
                          ),
                          onPressed: () async {
                            if (_key.currentState?.validate() ?? false) {
                              PreferenceManger().setString(
                                'username',
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
