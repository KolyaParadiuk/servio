import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servio/app/localization/translations.dart';
import 'package:servio/blocs/settings_bloc/settings_bloc.dart';
import 'package:servio/components/drawer.dart';
import 'package:servio/constants/app_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servio/constants/app_styles.dart';

class SettingsScreen extends StatelessWidget {
  final bool isWelcome;
  SettingsScreen({this.isWelcome = false});
  @override
  build(BuildContext context) {
    return Scaffold(
      drawer: this.isWelcome ? null : AppDrawer(),
      appBar: AppBar(
        title: Text(tr(AppStrings.settings)),
      ),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: BlocConsumer<SettingsBloc, SettingsState>(
              listener: (context, state) {
                if (state is SettingsControllersState) {
                  if (state.errorMessage != null) {
                    final snackBar = SnackBar(content: Text(state.errorMessage ?? "Error"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              },
              builder: (context, state) {
                if (state is SettingsControllersState)
                  return Column(
                    children: [
                      this.isWelcome
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 8.w, top: 24.w),
                              child: Text(tr(AppStrings.welcome), style: kTitle2),
                            )
                          : Container(),
                      TextField(
                        controller: state.addressInputController,
                        decoration: _buildInputDecoration(tr(AppStrings.serverAddress)),
                      ),
                      TextField(
                        controller: state.loginInputController,
                        decoration: _buildInputDecoration(tr(AppStrings.login)),
                      ),
                      TextField(
                        controller: state.passwordInputController,
                        decoration: _buildInputDecoration(tr(AppStrings.password)),
                      ),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<SettingsBloc>(context).add(SubmitEvent(context));
                        },
                        child: Text(tr(AppStrings.ok)),
                      )
                    ],
                  );
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String lable) {
    return InputDecoration(labelText: lable);
  }
}
