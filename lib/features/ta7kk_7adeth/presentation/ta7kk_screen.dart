import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_werd_app/core/widgets/app_background.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/data/repositories/ta7kk_repository_impl.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/cubit/ta7kk_cubit.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/cubit/ta7kk_state.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/widgets/ta7kk_empty_view.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/widgets/ta7kk_error_view.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/widgets/ta7kk_idle_view.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/widgets/ta7kk_loading_view.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/widgets/ta7kk_results_list.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/widgets/ta7kk_search_bar.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/widgets/ta7kk_source_footer.dart';

class Ta7kkScreen extends StatelessWidget {
  const Ta7kkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Ta7kkCubit(repository: Ta7kkRepositoryImpl()),
      child: const _Ta7kkView(),
    );
  }
}

class _Ta7kkView extends StatefulWidget {
  const _Ta7kkView();

  @override
  State<_Ta7kkView> createState() => _Ta7kkViewState();
}

class _Ta7kkViewState extends State<_Ta7kkView> {
  final _searchController = TextEditingController();

  void _search() {
    context.read<Ta7kkCubit>().search(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تحقق من صحة الأحاديث')),
      body: SafeArea(
        child: BlocBuilder<Ta7kkCubit, Ta7kkState>(
          builder: (context, state) {
            final isLoading = state.status == Ta7kkStatus.loading;

            return Stack(
              children: [
                const AppBackground(),
                Column(
                  children: [
                    Ta7kkSearchBar(
                      controller: _searchController,
                      isLoading: isLoading,
                      onSearch: _search,
                    ),
                    Expanded(child: _buildBody(state)),
                    const Ta7kkSourceFooter(),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(Ta7kkState state) {
    return switch (state.status) {
      Ta7kkStatus.loading => const Ta7kkLoadingView(),
      Ta7kkStatus.failure => Ta7kkErrorView(
        message: state.errorMessage ?? 'حدث خطأ غير متوقع',
        onRetry: _search,
      ),
      Ta7kkStatus.success when state.results.isEmpty => const Ta7kkEmptyView(),
      Ta7kkStatus.success => Ta7kkResultsList(results: state.results),
      Ta7kkStatus.initial => const Ta7kkIdleView(),
    };
  }
}
