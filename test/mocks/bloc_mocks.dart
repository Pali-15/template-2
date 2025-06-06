import 'package:mockito/annotations.dart';
import 'package:template/core/design/theme/theme_cubit.dart';
import 'package:template/core/l10n/locale_cubit.dart';
import 'package:template/app/screens/page_1/page_1_nested/bloc/bloc.dart';

@GenerateNiceMocks([
  MockSpec<LocaleCubit>(),
  MockSpec<ThemeCubit>(),
  MockSpec<Page1Bloc>(),
])
export 'bloc_mocks.mocks.dart';
