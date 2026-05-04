# Tasky

Tasky is a simple Flutter to-do app focused on daily execution: add tasks fast, mark progress, and keep priorities visible.

This project is intentionally local-first and lightweight. It does not depend on a backend, so you can run and test it quickly.

## Features

- Quick onboarding with user name.
- Add, edit, delete, and complete tasks.
- Mark tasks as high priority and review them in a dedicated screen.
- Separate tabs for Home, To Do, Completed, and Profile.
- Progress card showing completed tasks percentage.
- Profile updates (name, motivation quote, avatar from camera/gallery).
- Dark mode toggle.
- Local persistence using `SharedPreferences` (tasks, profile, theme).

## Tech Stack

- Flutter (Material UI)
- Provider (state management)
- Shared Preferences (local storage)
- image_picker + path_provider (avatar selection and storage)
- flutter_svg (SVG assets)

## Project Structure

```text
lib/
  core/
    components/      # reusable task widgets
    constants/       # local storage keys
    models/          # task data model
    services/        # shared preferences wrapper
    theme/           # light/dark themes and controller
    widgets/         # shared UI controls
  features/
    add_tasks/
    home/
    navigation/
    profile/
    tasks/
    welcome/
  main.dart
```

