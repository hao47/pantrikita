import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/feature/home/presentation/bloc/home_bloc.dart';
import 'package:pantrikita/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:pantrikita/feature/auth/presentation/bloc/login_bloc.dart';
import 'package:pantrikita/feature/auth/presentation/pages/register_page.dart';
import 'package:pantrikita/feature/pantry/presentation/bloc/pantry_bloc.dart';
import 'package:pantrikita/feature/recipe/presentation/bloc/recipe_bloc.dart';
import 'package:pantrikita/feature/recipe/presentation/bloc/recipe_detail_bloc.dart';

import '../../../feature/auth/presentation/bloc/register_bloc.dart';
import '../../../injection-container.dart';

class Provider {
  static  providers() {
    return [

      BlocProvider(
        create: (_) => sl.get<LoginBloc>(),
      ),
      BlocProvider(
      create: (_) => sl.get<RegisterBloc>(),
      ),
      BlocProvider(
        create: (_) => sl.get<ProfileBloc>(),
      ),
      BlocProvider(
        create: (_) => sl.get<PantryBloc>(),
      ),
      BlocProvider(
        create: (_) => sl.get<RecipeBloc>(),
      ),
      BlocProvider(
        create: (_) => sl.get<RecipeDetailBloc>(),
      ),
      BlocProvider(
        create: (_) => sl.get<HomeBloc>(),
      ),
    ];
  }
}
