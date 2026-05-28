import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

import 'screens/about/about_screen.dart';

import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

import 'screens/budgets/add_budget_screen.dart';
import 'screens/budgets/budgets_screen.dart';

import 'screens/categories/categories_screen.dart';

import 'screens/expense/add_expense_screen.dart';

import 'screens/goals/add_goal_screen.dart';
import 'screens/goals/goals_screen.dart';

import 'screens/home/home_screen.dart';

import 'screens/income/add_income_screen.dart';

import 'screens/profile/profile_screen.dart';

import 'screens/reports/reports_screen.dart';

import 'screens/search/search_screen.dart';

import 'screens/summary/summary_screen.dart';

import 'screens/transactions/edit_transaction_screen.dart';
import 'screens/transactions/transactions_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,

      locale:
          DevicePreview.locale(
        context,
      ),

      builder:
          DevicePreview.appBuilder,

      debugShowCheckedModeBanner:
          false,

      title:
          'FinControl',

      theme:
          AppTheme.lightTheme,

      initialRoute:
          AppRoutes.login,

      routes: {
        AppRoutes.login:
            (_) =>
                const LoginScreen(),

        AppRoutes.register:
            (_) =>
                const RegisterScreen(),

        AppRoutes.forgotPassword:
            (_) =>
                const ForgotPasswordScreen(),

        AppRoutes.home:
            (_) =>
                const HomeScreen(),

        AppRoutes.addIncome:
            (_) =>
                const AddIncomeScreen(),

        AppRoutes.addExpense:
            (_) =>
                const AddExpenseScreen(),

        AppRoutes.transactions:
            (_) =>
                const TransactionsScreen(),

        AppRoutes.editTransaction:
            (_) =>
                const EditTransactionScreen(),

        AppRoutes.summary:
            (_) =>
                const SummaryScreen(),

        AppRoutes.goals:
            (_) =>
                const GoalsScreen(),

        AppRoutes.addGoal:
            (_) =>
                const AddGoalScreen(),

        AppRoutes.search:
            (_) =>
                const SearchScreen(),

        AppRoutes.about:
            (_) =>
                const AboutScreen(),

        AppRoutes.profile:
            (_) =>
                const ProfileScreen(),

        AppRoutes.categories:
            (_) =>
                const CategoriesScreen(),

        AppRoutes.reports:
            (_) =>
                const ReportsScreen(),

        AppRoutes.budgets:
            (_) =>
                const BudgetsScreen(),

        AppRoutes.addBudget:
            (_) =>
                const AddBudgetScreen(),
      },
    );
  }
}