# 🚀 FVM Setup Guide for Your Flutter Project

## Why Use FVM?
Flutter Version Management (FVM) allows you to:
- ✅ Manage multiple Flutter SDK versions per project
- ✅ Ensure consistent Flutter versions across team members
- ✅ Switch between Flutter versions seamlessly
- ✅ Test with different Flutter releases easily

## 📦 Step 1: Install FVM

Run these commands in your **local terminal** (on your Mac):

```bash
# Add the FVM tap to Homebrew
brew tap leoafarias/fvm

# Install FVM
brew install fvm
```

## 🎯 Step 2: Set Up FVM for This Project

Navigate to your project directory and set up FVM:

```bash
# Navigate to your project
cd /path/to/your/flutter-ddd-starter

# Check what Flutter versions are available
fvm releases

# Install and use a specific Flutter version (recommended: stable)
fvm install stable
fvm use stable

# Or use a specific version like 3.19.0
# fvm install 3.19.0
# fvm use 3.19.0
```

This will create a `.fvmrc` file in your project root that locks the Flutter version.

## ⚙️ Step 3: Configure VS Code

FVM will automatically configure VS Code for you. After running `fvm use`, check that these files are created/updated:

**`.vscode/settings.json`**:
```json
{
  "dart.flutterSdkPath": ".fvm/flutter_sdk"
}
```

## 🔧 Step 4: Update Your Scripts

Update the test script to use FVM:

**`test_migration.sh`** (I'll update this for you):
```bash
#!/bin/bash

echo "🚀 Testing Hive Migration with FVM..."
echo ""

# Test just our Hive migration
echo "1. Testing Hive Migration Implementation..."
fvm flutter test test/shared/infrastructure/security/hive_migration_test.dart

echo ""
echo "2. Testing all tests..."
fvm flutter test

echo ""
echo "✅ Migration testing completed!"
```

## 🚀 Step 5: Use FVM Commands

From now on, use `fvm` prefix for all Flutter commands:

```bash
# Get packages
fvm flutter packages get

# Run build runner
fvm flutter packages pub run build_runner build --delete-conflicting-outputs

# Run tests
fvm flutter test

# Run the app
fvm flutter run

# Check Flutter doctor
fvm flutter doctor
```

## 📋 Useful FVM Commands

```bash
# List installed Flutter versions
fvm list

# List available Flutter releases
fvm releases

# Install a specific version
fvm install 3.19.0

# Set global default version
fvm global stable

# Check current project version
fvm use

# Remove a version
fvm remove 3.19.0
```

## 🎯 Step 6: Test Your Hive Migration

Once FVM is set up, test your migration:

```bash
# Test the migration
fvm flutter test test/shared/infrastructure/security/hive_migration_test.dart

# Run all tests
fvm flutter test

# Get packages (if needed)
fvm flutter packages get
```

## 📁 Expected Project Structure

After FVM setup, your project will have:

```
flutter-ddd-starter/
├── .fvmrc                          # FVM version lock file
├── .fvm/                           # FVM cache directory
│   └── flutter_sdk/               # Symlink to Flutter SDK
├── .vscode/
│   └── settings.json              # VS Code Flutter SDK path
├── test_migration.sh              # Updated test script
└── ... (rest of your project)
```

## ✅ Benefits for Your Project

With FVM set up:
- 🔒 **Consistent Environment**: Everyone uses the same Flutter version
- 🚀 **Easy Testing**: Test with different Flutter versions easily
- 🛠️ **Better CI/CD**: Specify exact Flutter versions in deployment
- 👥 **Team Collaboration**: No more "works on my machine" issues

## 🔧 Troubleshooting

If you encounter issues:

1. **VS Code not recognizing Flutter**: Restart VS Code after FVM setup
2. **Commands not found**: Make sure FVM is in your PATH
3. **Version conflicts**: Run `fvm flutter clean` and `fvm flutter packages get`

Run these commands on your local machine to get started! 🎉