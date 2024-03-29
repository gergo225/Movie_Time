import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/domain/actor/actor_info.dart';
import 'package:movie_time/domain/actor/actor_credit_info.dart';
import 'package:movie_time/domain/actor/get_actor_by_id.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/presentation/actor/actor_bloc.dart';

class MockGetActorById extends Mock implements GetActorById {}

void main() {
  ActorBloc bloc;
  MockGetActorById mockGetActorById;

  setUp(() {
    mockGetActorById = MockGetActorById();
    bloc = ActorBloc(getActorById: mockGetActorById);
  });

  group("GetInfoForActorById", () {
    final actorId = 287;
    final actorMovieInfo = ActorCreditInfo(
      id: 163,
      title: "Ocean's Twelve",
      character: "Rusty Ryan",
      posterPath: "/oV3BVdY3UtEHRxpixmntpxHJwSc.jpg",
    );
    final actorInfo = ActorInfo(
        id: 287,
        name: "Brad Pitt",
        birthday: "1963-12-18",
        bio:
            "William Bradley \"Brad\" Pitt (born December 18, 1963) is an American actor and film producer. Pitt has received two Academy Award nominations and four Golden Globe Award nominations, winning one. He has been described as one of the world's most attractive men, a label for which he has received substantial media attention. Pitt began his acting career with television guest appearances, including a role on the CBS prime-time soap opera Dallas in 1987. He later gained recognition as the cowboy hitchhiker who seduces Geena Davis's character in the 1991 road movie Thelma & Louise. Pitt's first leading roles in big-budget productions came with A River Runs Through It (1992) and Interview with the Vampire (1994). He was cast opposite Anthony Hopkins in the 1994 drama Legends of the Fall, which earned him his first Golden Globe nomination. In 1995 he gave critically acclaimed performances in the crime thriller Seven and the science fiction film 12 Monkeys, the latter securing him a Golden Globe Award for Best Supporting Actor and an Academy Award nomination.\n\nFour years later, in 1999, Pitt starred in the cult hit Fight Club. He then starred in the major international hit as Rusty Ryan in Ocean's Eleven (2001) and its sequels, Ocean's Twelve (2004) and Ocean's Thirteen (2007). His greatest commercial successes have been Troy (2004) and Mr. & Mrs. Smith (2005).\n\nPitt received his second Academy Award nomination for his title role performance in the 2008 film The Curious Case of Benjamin Button. Following a high-profile relationship with actress Gwyneth Paltrow, Pitt was married to actress Jennifer Aniston for five years. Pitt lives with actress Angelina Jolie in a relationship that has generated wide publicity. He and Jolie have six children—Maddox, Pax, Zahara, Shiloh, Knox, and Vivienne.\n\nSince beginning his relationship with Jolie, he has become increasingly involved in social issues both in the United States and internationally. Pitt owns a production company named Plan B Entertainment, whose productions include the 2007 Academy Award winning Best Picture, The Departed.",
        imagePath: "/kU3B75TyRiCgE270EyZnHjfivoq.jpg",
        credits: [actorMovieInfo]);

    test("should get data from the usecase", () async {
      // arrange
      when(mockGetActorById(any)).thenAnswer((_) async => Right(actorInfo));
      // act
      bloc.add(GetInfoForActorById(actorId));
      await untilCalled(mockGetActorById(any));
      // assert
      verify(mockGetActorById(Params(id: actorId)));
    });

    test("initial state should be Loading", () async {
      // assert
      expect(bloc.state, equals(Loading()));
    });

    test("should emit [Loaded] when data is gotten successfully", () async {
      // arrange
      when(mockGetActorById(any)).thenAnswer((_) async => Right(actorInfo));
      // assert later
      final expected = [
        Loaded(actor: actorInfo),
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetInfoForActorById(actorId));
    });

    test("should emit [Error] when getting data fails", () async {
      // arrange
      when(mockGetActorById(any)).thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetInfoForActorById(actorId));
    });
  });
}
