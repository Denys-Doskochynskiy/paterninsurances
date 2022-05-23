import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paterninsurances/api/insurance/insurance_model.dart';
import 'package:paterninsurances/blocs/insurances_bloc/insurances_bloc.dart';
import 'package:paterninsurances/blocs/login_bloc/login_bloc.dart';
import 'package:paterninsurances/components/insurances/insurance_item.dart';

class InsuranceView extends StatefulWidget {
  const InsuranceView({Key? key}) : super(key: key);

  @override
  State<InsuranceView> createState() => _InsuranceViewState();
}

class _InsuranceViewState extends State<InsuranceView> {
  @override
  void initState() {
    super.initState();
    InsurancesBloc _bloc = BlocProvider.of<InsurancesBloc>(context);
    _bloc.add(const LoadInsuranceList());
  }

  @override
  Widget build(BuildContext context) {
    InsurancesBloc _bloc = BlocProvider.of<InsurancesBloc>(context);
    LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);
    return DefaultTabController(
      length: 2,
      child: BlocListener<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listener: (context, state) {
          if (state is SuccessLogoutUser) {
            Navigator.of(context).pushNamed("/");
          }
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black.withOpacity(0.8),
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Flutter Insurances'),
                  InkWell(
                      onTap: () => _loginBloc.add(const LogoutUserEvent()),
                      child: const Icon(Icons.logout))
                ],
              ),
              bottom: const TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(text: "Personal Insurance"),
                  Tab(text: "General Insurance"),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamed("/create"),
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.add,
              ),
            ),
            body: BlocBuilder<InsurancesBloc, InsurancesState>(
              bloc: _bloc,
              builder: (context, state) {
                return TabBarView(children: [
                  SingleChildScrollView(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: (state is InsurancesLoaded)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocBuilder<LoginBloc, LoginState>(
                                      builder: (context, loginState) {
                                        return (loginState is LoginInitial)
                                            ? _personalInsurance(state
                                                .insuranceList
                                                .where((element) =>
                                                    element.reservedByUser ==
                                                    loginState.userEmail)
                                                .toList())
                                            : const CircularProgressIndicator();
                                      },
                                    )
                                  ],
                                )
                              : const CircularProgressIndicator())),
                  SingleChildScrollView(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: (state is InsurancesLoaded)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _globalInsurance(state.insuranceList
                                        .where(
                                            (element) => !element.isAvailable)
                                        .toList())
                                  ],
                                )
                              : const CircularProgressIndicator())),
                ]);
              },
            )),
      ),
    );
  }

  Widget _globalInsurance(List<InsuranceModel> insuranceList) {
    return Column(
        children:
            insuranceList.map((data) => InsuranceItem(data: data)).toList());
  }

  Widget _personalInsurance(List<InsuranceModel> insuranceList) {
    InsurancesBloc _bloc = BlocProvider.of<InsurancesBloc>(context);
    return Column(
        children: insuranceList
            .map((data) => Dismissible(
                  onDismissed: (_) =>
                      _bloc.add(DeleteInsurances(data.id.toString())),
                  key: Key(data.id.toString()),
                  child: InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed("/edit", arguments: data.id),
                      child: InsuranceItem(data: data)),
                ))
            .toList());
  }
}
