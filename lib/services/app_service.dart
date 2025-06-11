import 'package:daily_bite/app/app_bloc/app_bloc.dart';
import 'package:daily_bite/services/setup_dependencies.dart';

class AppService {
  final AppBloc _appBloc = getIt<AppBloc>();

  void showLoader() => _appBloc.add(ShowLoaderEvent());

  void hideLoader() => _appBloc.add(HideLoaderEvent());

  void showError() => _appBloc.add(ShowErrorEvent());
}
