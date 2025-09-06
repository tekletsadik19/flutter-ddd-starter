#!/bin/bash

echo "🚀 Testing Hive Migration..."
echo ""

# Test just our Hive migration
echo "1. Testing Hive Migration Implementation..."
flutter test test/shared/infrastructure/security/hive_migration_test.dart

echo ""
echo "2. Testing all tests..."
flutter test

echo ""
echo "✅ Migration testing completed!"