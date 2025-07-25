import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/core/widgets/button.dart';
import 'package:pantrikita/feature/recipe/presentation/bloc/recipe_bloc.dart';

class WidgetRecipeError extends StatelessWidget {
  final RecipeFailure state;

  const WidgetRecipeError({super.key, required this.state});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getErrorIcon(),
              size: 80,
              color: _getErrorColor(),
            ),
            const SizedBox(height: 24),

            Text(
              _getErrorTitle(),
              style: tsTitleMediumBold(ColorValue.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            Text(
              state.message,
              style: tsBodyMediumRegular(ColorValue.grayDark),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            _buildActionButtons(context),

            if (_isNetworkError()) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue.shade700,
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tips:',
                      style: tsBodyMediumBold(Colors.blue.shade700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '• Check your internet connection\n• Try switching to mobile data or WiFi\n• Make sure you\'re not in airplane mode',
                      style: tsBodySmallRegular(Colors.blue.shade700),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  bool _isNetworkError() {
      return state.failureType!.contains('NetworkFailure');
  }

  bool _isServerError() {
      return state.failureType!.contains('ServerFailure');
  }

  bool _isTimeoutError() {
      return state.failureType!.contains('TimeOutFailure');
  }

  IconData _getErrorIcon() {
    if (_isNetworkError()) {
      return Icons.wifi_off;
    } else if (_isServerError()) {
      return Icons.cloud_off;
    } else if (_isTimeoutError()) {
      return Icons.access_time;
    } else {
      return Icons.error_outline;
    }
  }

  Color _getErrorColor() {
    if (_isNetworkError()) {
      return Colors.orange;
    } else if (_isServerError()) {
      return ColorValue.red;
    } else if (_isTimeoutError()) {
      return Colors.blue;
    } else {
      return ColorValue.red;
    }
  }

  String _getErrorTitle() {
    if (_isNetworkError()) {
      return 'No Internet Connection';
    } else if (_isServerError()) {
      return 'Server Error';
    } else if (_isTimeoutError()) {
      return 'Connection Timeout';
    } else {
      return 'Something Went Wrong';
    }
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        MyButton(
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.refresh, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                'Try Again',
                style: tsBodyMediumBold(Colors.white),
              ),
            ],
          ),
          onPressed: () {
            context.read<RecipeBloc>().add(GetRecipesEvent());
          },
          colorbtn: WidgetStateProperty.all<Color>(ColorValue.primary),
          width: double.infinity,
        ),
      ],
    );
  }
}