import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:servio/app/localization/translations.dart';
import 'package:servio/blocs/digests_bloc/digests_bloc.dart';
import 'package:servio/components/date_input.dart';
import 'package:servio/components/drawer.dart';
import 'package:servio/constants/app_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DigestsScreen extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(tr(AppStrings.digests)),
      ),
      body: BlocBuilder<DigestsBloc, DigestsState>(
        builder: (context, state) {
          if (state is DigestData)
            return SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DateInput(
                          lable: tr(AppStrings.dateFrom),
                          initValue: state.from,
                          onChange: (d) {
                            BlocProvider.of<DigestsBloc>(context).add(ChangeTimeFrom(d));
                          },
                        ),
                        DateInput(
                          lable: tr(AppStrings.dateTo),
                          initValue: state.to,
                          onChange: (d) {
                            BlocProvider.of<DigestsBloc>(context).add(ChangeTimeTo(d));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
