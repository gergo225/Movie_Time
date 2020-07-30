import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/domain/actor/actor_info.dart';
import 'package:movie_time/domain/actor/actor_info_repository.dart';
import 'package:movie_time/domain/actor/actor_credit_info.dart';
import 'package:movie_time/domain/actor/get_actor_by_id.dart';
import 'package:movie_time/domain/core/failure.dart';

class MockActorInfoRepository extends Mock implements ActorInfoRepository {}

class TestFailure extends Failure {}

void main() {
  GetActorById usecase;
  MockActorInfoRepository mockActorInfoRepository;

  setUp(() {
    mockActorInfoRepository = MockActorInfoRepository();
    usecase = GetActorById(mockActorInfoRepository);
  });

  final actorId = 287;
  final actorCreditInfo = ActorCreditInfo(
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
      credits: [actorCreditInfo]);

  test("should get actor info for the id", () async {
    // arrange
    when(mockActorInfoRepository.getActorById(any))
        .thenAnswer((_) async => Right(actorInfo));
    // act
    final result = await usecase(Params(id: actorId));
    // assert
    expect(result, Right(actorInfo));
    verify(mockActorInfoRepository.getActorById(actorId));
    verifyNoMoreInteractions(mockActorInfoRepository);
  });

  final failure = TestFailure();

  test("should get failure if the actor with id is not found", () async {
    // arrange
    when(mockActorInfoRepository.getActorById(any))
        .thenAnswer((_) async => Left(failure));
    // act
    final result = await usecase(Params(id: actorId));
    // assert
    expect(result, Left(failure));
  });
}
