import 'package:ddd_flutter_app/core/di/injection_container.dart';
import 'package:ddd_flutter_app/features/counter/presentation/cubits/counter_cubit.dart';
import 'package:ddd_flutter_app/features/counter/presentation/widgets/counter_view.dart';
import 'package:ddd_flutter_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Counter page with dependency injection
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CounterCubit>(),
      child: const CounterView(),
    );
  }
}

/// Counter page scaffold
class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.counterAppBarTitle),
        actions: [
          IconButton(
            onPressed: () => context.read<CounterCubit>().reset(),
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Counter',
          ),
        ],
      ),
      body: const CounterBody(),
      floatingActionButton: const CounterFloatingActionButtons(),
    );
  }
}
