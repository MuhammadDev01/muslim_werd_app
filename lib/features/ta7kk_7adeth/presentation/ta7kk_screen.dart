import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/data/repositories/ta7kk_repository_impl.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/domain/models/hadith_ta7kk_result.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/cubit/ta7kk_cubit.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/cubit/ta7kk_state.dart';

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

            return Column(
              children: [
                _SearchCard(
                  controller: _searchController,
                  isLoading: isLoading,
                  onSearch: _search,
                ),
                Expanded(child: _buildBody(state)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(Ta7kkState state) {
    return switch (state.status) {
      Ta7kkStatus.loading => const _LoadingView(),
      Ta7kkStatus.failure => _ErrorView(message: state.errorMessage ?? 'حدث خطأ غير متوقع', onRetry: _search),
      Ta7kkStatus.success when state.results.isEmpty => const _EmptyResultsView(),
      Ta7kkStatus.success => _ResultsList(results: state.results),
      Ta7kkStatus.initial => const _IdleView(),
    };
  }
}

class _SearchCard extends StatelessWidget {
  const _SearchCard({
    required this.controller,
    required this.isLoading,
    required this.onSearch,
  });

  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.gold, width: 1.2),
            ),
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => onSearch(),
              decoration: InputDecoration(
                hintText: 'اكتب كلمات مفتاحية من الحديث...',
                hintStyle: TextStyle(
                  fontFamily: fontCairo,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: onSearch,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              icon: Icon(isLoading ? Icons.hourglass_top_rounded : Icons.search_rounded, size: 20),
              label: Text(
                isLoading ? 'جاري البحث...' : 'بحث',
                style: const TextStyle(fontFamily: fontCairo, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 4),
          ),
          const SizedBox(height: 20),
          Text(
            'جاري استرجاع بيانات الحديث...',
            style: TextStyle(
              fontFamily: fontCairo,
              fontSize: 15,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _IdleView extends StatelessWidget {
  const _IdleView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_rounded, size: 64, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 16),
          Text(
            'ابدأ بحثك عن الحديث',
            style: TextStyle(fontFamily: fontCairo, fontSize: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 6),
          Text(
            'اكتب كلمات مفتاحية ثم اضغط زر البحث',
            style: TextStyle(fontFamily: fontCairo, fontSize: 13, color: Theme.of(context).colorScheme.outline),
          ),
        ],
      ),
    );
  }
}

class _EmptyResultsView extends StatelessWidget {
  const _EmptyResultsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 64, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 16),
          Text(
            'لا توجد نتائج مطابقة',
            style: TextStyle(fontFamily: fontCairo, fontSize: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off_rounded, size: 64, color: AppColors.gold),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: fontCairo, fontSize: 15, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onRetry,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('إعادة المحاولة', style: TextStyle(fontFamily: fontCairo, fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultsList extends StatelessWidget {
  const _ResultsList({required this.results});

  final List<HadithTa7kkResult> results;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: results.length,
      itemBuilder: (context, index) => _ResultCard(result: results[index], number: index + 1),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result, required this.number});

  final HadithTa7kkResult result;
  final int number;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final status = result.gradeStatus;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.gold, width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .06), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(
                  '$number',
                  style: const TextStyle(fontFamily: fontCairo, fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.white),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'خلاصة الحكم',
                  style: TextStyle(
                    fontFamily: fontCairo,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                  ),
                ),
              ),
              _GradeBadge(status: status, grade: result.grade),
            ],
          ),
          const SizedBox(height: 12),
          Text(result.text, style: const TextStyle(fontFamily: fontAmiri, fontSize: 16, height: 1.8, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 10),
          _InfoRow(label: 'الراوي', value: result.rawi),
          _InfoRow(label: 'المحدث', value: result.mohdith),
          _InfoRow(label: 'المصدر', value: result.book),
          if (result.pageNumber.isNotEmpty) _InfoRow(label: 'الصفحة أو الرقم', value: result.pageNumber),
        ],
      ),
    );
  }
}

class _GradeBadge extends StatelessWidget {
  const _GradeBadge({required this.status, required this.grade});

  final HadithGradeStatus status;
  final String grade;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      HadithGradeStatus.sahih => (const Color(0xFF168A5B), 'صحيح'),
      HadithGradeStatus.hasan => (const Color(0xFF8A6D2F), 'حسن'),
      HadithGradeStatus.daeef => (const Color(0xFF8A4A2F), 'ضعيف'),
      HadithGradeStatus.other => (const Color(0xFF66736C), 'انظر الحكم'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(fontFamily: fontCairo, fontSize: 13, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) return const SizedBox.shrink();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontFamily: fontCairo, fontSize: 13, fontWeight: FontWeight.bold, color: isDark ? AppColors.darkTextSecondary : AppColors.primary),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontFamily: fontCairo, fontSize: 13, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}