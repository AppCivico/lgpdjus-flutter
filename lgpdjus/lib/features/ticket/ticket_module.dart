import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/core/di/bind.dart';
import 'package:lgpdjus/core/di/feature_module.dart';
import 'package:lgpdjus/features/ticket/data/repositories/ticket_repository.dart';
import 'package:lgpdjus/features/ticket/domain/repository/ticket_repository.dart';
import 'package:lgpdjus/features/ticket/domain/usecases/ticket_usecases.dart';
import 'package:lgpdjus/features/ticket/presentation/detail/ticket_detail_controller.dart';
import 'package:lgpdjus/features/ticket/presentation/detail/ticket_detail_page.dart';
import 'package:lgpdjus/features/ticket/presentation/list/tickets_controller.dart';
import 'package:lgpdjus/features/ticket/presentation/list/tickets_page.dart';
import 'package:lgpdjus/features/ticket/presentation/reply/ticket_reply_controller.dart';
import 'package:lgpdjus/features/ticket/presentation/reply/ticket_reply_page.dart';

class TicketModule extends Module with FeatureModule {
  @override
  late final List<ModularRoute> routes = [
    ChildRoute(
      '/available',
      child: (context, args) => TicketsPage(
        title: 'Meus Dados Pessoais',
        theme: args.data?.of(context),
      ),
      transition: TransitionType.rightToLeft,
    ),
    ChildRoute(
      '/my',
      child: (context, args) => TicketsPage(
        title: 'Minhas solicitações',
        theme: args.data?.of(context),
      ),
      transition: TransitionType.rightToLeft,
    ),
    ChildRoute(
      '/:id',
      child: (_, args) => TicketDetailPage(),
      transition: TransitionType.rightToLeft,
    ),
    ChildRoute(
      '/:ticket/reply/:id',
      child: (_, args) => TicketReplyPage(args.data),
      transition: TransitionType.rightToLeft,
    ),
  ];

  @override
  List<Bind> get presentationBinds => [
        Bind.factory(
          (i) => TicketsController(
            getTicketList: Modular.getBindTagged(i.args?.uri?.path ?? ''),
          ),
        ),
        Bind.factory(
          (i) => TicketDetailController(
            ticketId: i.args?.params['id'],
            getTicket: i(),
          ),
        ),
        Bind.factory(
          (i) => TicketReplyController(
            sendTicketReply: i(),
          ),
        )
      ];

  @override
  List<Bind> get domainBinds => [
        BindTagged<GetTicketListUseCase>(
          '/mainboard/tickets/available',
          (i) => GetAvailableTicketsUseCase(i()),
        ),
        BindTagged<GetTicketListUseCase>(
          '/mainboard/tickets/my',
          (i) => GetMineTicketsUseCase(i()),
        ),
        Bind.factory(
          (i) => GetTicketUseCase(i()),
        ),
        Bind.factory(
          (i) => SendTicketReplyUseCase(
            repository: i(),
            fileRepository: i(),
            ticketId: i.args!.params['ticket'],
            replyId: i.args!.params['id'],
          ),
        ),
      ];

  @override
  List<Bind> get dataBinds => [
        Bind.factory<ITicketsRepository>(
          (i) => TicketsRepository(
            httpClient: i(),
            authObserver: i(),
          ),
        ),
      ];
}
