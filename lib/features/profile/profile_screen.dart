import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/services/file_storage_manger.dart';
import 'package:tasky_app/core/services/preference_manger.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/widgets/custom_svg_picture.dart';
import 'package:tasky_app/features/profile/user_details_screen.dart';
import 'package:tasky_app/features/tasks/controllers/tasks_controller.dart';
import 'package:tasky_app/features/welcome/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String userName;
  late String motivationQuote;
  bool isLoading = true;
  String? userImagePath;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.pw16,
              vertical: AppSizes.ph16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: AppSizes.h8),
                  child: Text(
                    'My Profile',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                SizedBox(height: AppSizes.h16),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: AlignmentGeometry.bottomRight,

                        children: [
                          CircleAvatar(
                            radius: AppSizes.w55,
                            backgroundImage: userImagePath == null
                                ? AssetImage('assets/images/avtare.png')
                                : FileImage(File(userImagePath!)),
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            onTap: () async {
                              _showImageSourceDialog(context, (
                                XFile selectedFile,
                              ) {
                                _saveImage(selectedFile);
                                setState(() {
                                  userImagePath = selectedFile.path;
                                });
                              });
                            },
                            child: Container(
                              width: AppSizes.w45,
                              height: AppSizes.h45,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(
                                  AppSizes.r100,
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: AppSizes.r26,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.h6),

                      Text(
                        userName,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        motivationQuote,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.ph24),
                Text(
                  'Profile Info',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: AppSizes.ph24),
                ListTile(
                  onTap: () async {
                    final result = await await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UserDetailsScreen(
                            motivationQuote: motivationQuote,
                            userName: userName,
                          );
                        },
                      ),
                    );
                    if (result != null && result) {
                      _loadData();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  title: const Text('User Details'),

                  leading: const CustomSvgPicture(
                    path: 'assets/images/user_details_icon.svg',
                  ),
                  trailing: const CustomSvgPicture(
                    path: 'assets/images/arrow_right_icon.svg',
                  ),
                ),

                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Dark Mode'),
                  leading: const CustomSvgPicture(
                    path: 'assets/images/dark_mode_icon.svg',
                  ),
                  trailing: ValueListenableBuilder<ThemeMode>(
                    valueListenable: ThemeController.themeNotifier,
                    builder: (context, value, child) {
                      return Switch(
                        value:
                            ThemeController.themeNotifier.value ==
                            ThemeMode.dark,
                        onChanged: (value) async {
                          ThemeController.toggleTheme();
                        },
                      );
                    },
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () async {
                    await PreferenceManger().remove(StorageKey.userName);
                    await PreferenceManger().remove(StorageKey.motivationQuote);
                    // await PreferenceManger().remove(StorageKey.tasks);
                    await FileStorageManger().clear();
                    if (!context.mounted) return;
                    context.read<TasksController>().clearTasks();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WelcomeScreen();
                        },
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Log Out'),

                  leading: const CustomSvgPicture(
                    path: 'assets/images/logout_icon.svg',
                  ),
                  trailing: const CustomSvgPicture(
                    path: 'assets/images/arrow_right_icon.svg',
                  ),
                ),
              ],
            ),
          );
  }

  void _loadData() async {
    setState(() {
      userName = PreferenceManger().getString(StorageKey.userName) ?? '';
      motivationQuote =
          PreferenceManger().getString(StorageKey.motivationQuote) ??
          'One task at a time. One step closer.';
      userImagePath = PreferenceManger().getString(StorageKey.userImage);
      isLoading = false;
    });
  }

  void _showImageSourceDialog(
    BuildContext context,
    void Function(XFile) selectedFile,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            'Choose Image Source',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.pw16,
                vertical: AppSizes.ph16,
              ),

              onPressed: () async {
                if (!mounted) return;
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: Row(
                children: [
                  const Icon(Icons.camera_alt),
                  SizedBox(width: AppSizes.w8),
                  const Text('Camera'),
                ],
              ),
            ),
            SimpleDialogOption(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.pw16,
                vertical: AppSizes.ph16,
              ),
              onPressed: () async {
                if (!mounted) return;
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: Row(
                children: [
                  const Icon(Icons.photo_library),
                  SizedBox(width: AppSizes.w8),
                  const Text('Gallery'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    PreferenceManger().setString(StorageKey.userImage, newFile.path);
  }
}
