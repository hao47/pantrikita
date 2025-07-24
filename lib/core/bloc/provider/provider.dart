import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/feature/auth/presentation/bloc/login_bloc.dart';
import 'package:pantrikita/feature/pantry/presentation/bloc/pantry_bloc.dart';

import '../../../injection-container.dart';

class Provider {
  static providers() {
    return [
      BlocProvider(
        create: (_) => sl.get<PantryBloc>(),
      ),
      BlocProvider(
        create: (_) => sl.get<LoginBloc>(),
      ),
    ];
  }
}