import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/ui/bloc/visiting_bloc.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/scaffold_messenger_extension.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/simple_app_bar.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/sliver_sight_list.dart';

/// Экран "Избранное".
class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  late final VisitingBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = VisitingBloc(placeInteractor: context.placeInteractor)
      ..add(const VisitingBlocEvent.load(hidden: false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: SimpleAppBar(
            title: AppStrings.favoritesTitle,
            bottom: const _Tabs(
              items: [
                AppStrings.myWishList,
                AppStrings.alreadyVisited,
              ],
            ),
          ),
          body: BlocConsumer<VisitingBloc, VisitingBlocState>(
            bloc: _bloc,

            /// Если ошибка сортировки, показываем SnackBar.
            listenWhen: _needListen,
            listener: (_, state) {
              if (state is ErrorVisitingBlocState) {
                ScaffoldMessenger.of(context).showError(
                  state.message,
                  critical: state.critical,
                );
              }
            },

            /// В остальных случах перестраиваем виджет.
            buildWhen: _needRebuild,
            builder: (context, state) {
              /// Прогресс
              if (state is LoadingVisitingBlocState) {
                return const Loader();
              }

              /// Ошибка
              if (state is ErrorVisitingBlocState) {
                return EmptyList(
                  icon: AppIcons.error,
                  title: AppStrings.error,
                  details: state.message,
                );
              }

              if (state is! DoneVisitingBlocState) {
                throw UnimplementedError('');
              }

              final data = state.sights;

              return TabBarView(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverSightList(
                        sights: data
                            .where((sight) => !sight.isVisited)
                            .toList(growable: false),
                        empty: const EmptyList(
                          icon: AppIcons.card,
                          title: AppStrings.empty,
                          details: AppStrings.tagPlaces,
                        ),
                        mode: CardMode.favorites,
                        onOrderChanged: (sourceId, insertAfterId) =>
                            _onDragComplete(
                          context,
                          sourceId,
                          insertAfterId,
                        ),
                      ),
                    ],
                  ),
                  CustomScrollView(
                    slivers: [
                      SliverSightList(
                        sights: data
                            .where((sight) => sight.isVisited)
                            .toList(growable: false),
                        empty: const EmptyList(
                          icon: AppIcons.goRouteBig,
                          title: AppStrings.empty,
                          details: AppStrings.finishRoute,
                        ),
                        mode: CardMode.favorites,
                        onOrderChanged: (sourceId, insertAfterId) =>
                            _onDragComplete(
                          context,
                          sourceId,
                          insertAfterId,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  /// Определяет необходимость сайд-эффектов.
  bool _needListen(VisitingBlocState _, VisitingBlocState current) =>
      current is ErrorVisitingBlocState &&
      current.source == ErrorSource.reorder;

  /// Определяет необходимость перестроения виджетов.
  bool _needRebuild(VisitingBlocState prev, VisitingBlocState current) =>
      !_needListen(prev, current);

  /// Обработчик завершения сортировки.
  void _onDragComplete(
    BuildContext context,
    int sourceId,
    int? insertAfterId,
  ) {
    BlocProvider.of<VisitingBloc>(context).add(
      VisitingBlocEvent.reorder(
        sourceId: sourceId,
        insertBeforeId: insertAfterId,
      ),
    );
  }
}

/// Переключатель страниц.
class _Tabs extends StatelessWidget implements PreferredSizeWidget {
  final List<String> items;

  @override
  Size get preferredSize => const Size(double.infinity, 52.0);

  const _Tabs({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        clipBehavior: Clip.antiAlias,
        // TODO(novikov): Добавить splash c закруглением при нажатии
        // Судя по исходникам TabBar, каждый таб оборачивается в InkWell,
        // поэтому штатными средствами можно только убрать splash.
        // Ждем-с: https://github.com/flutter/flutter/issues/50341
        child: Container(
          height: 40.0,
          color: Theme.of(context).cardColor,
          child: TabBar(
            tabs: items.map(Text.new).toList(growable: false),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
