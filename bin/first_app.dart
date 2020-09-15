import 'models.dart';

Map fillComands(List<String> nameOfComands, List commandFunction) {
  return Map.fromIterables(nameOfComands, commandFunction);
}

// ignore: missing_return
int checkTimeForEnd(Event event) {
  var startingTime = event.startingTime;
  var planingWorkTime = event.timeForWork;

  var currentTime = DateTime.now();
  var timeForEnd = startingTime.add(planingWorkTime);

  try {
    return timeForEnd.difference(currentTime).inMinutes;
  } on Exception catch (e) {
    print(e);
  }
}

void serviceForPretifyOutput(Map map) {
  map.forEach((key, value) {
    if (value is List) {
      if (value.length > 1) {
        value.forEach((element) {
          print('${key} is going to do: \n${element}');
          print(
              'Time for making tis left: ${checkTimeForEnd(element)} minutes');
        });
      } else {
        try {
          print('${key} is going to do: \n${value[0]}');
          print(
              'Time for making this lefts: ${checkTimeForEnd(value[0])} minutes');
        } on IndexError catch (e) {
          print('${key} is going to do: nothing');
        }
      }
    }
  });
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}

List splitedWithoutDigit(String sentence) {
  var listOfWords = sentence.split(" ");
  return listOfWords.where((x) => !isNumeric(x)).toList();
}

// ignore: always_declare_return_types
handleRemovingEvent(Board board, int number) {
  var event = board.events.removeAt(number);
  board.usersEvents.forEach((user, events) {
    events.remove(event);
  });
}

// function for working with our data structers

//map with many function
void main(List<String> arguments) {
  print('Hello world!');

  var commands = <String>[
    'Add a new user',
    'Delete a user',
    'Add a new event',
    'Pick event and cut for word without numbers',
    'Delete an user\'s event'
  ];

  var functions = <Function>[
    (String firstName, String secondName, int age, [time]) =>
        User(firstName, secondName, age, time),
    (Set<User> users, user) => users.remove(user),
    (String title, String description, DateTime startingTime,
            Duration duration) =>
        Event(title, description, startingTime, duration),
    (List<Event> events, int number) =>
        splitedWithoutDigit(events[number].description),
    (Board board, int number) => handleRemovingEvent(board, number)
  ];

  var invoker = fillComands(commands, functions);

  //using cascades(..)

  Board board = Board()
    ..setUsers = invoker['Add a new user']('Pasha', 'Snizhko', 20)
    ..setEvents = invoker['Add a new event'](
        '1. Event\n', 'Do homework', DateTime.now(), new Duration(minutes: 120))
    ..setEvents = invoker['Add a new event'](
        '2. Event\n',
        'Go to the store and make dinner',
        new DateTime(2020, 10, 15, 12, 30, 5),
        new Duration(minutes: 60));

  serviceForPretifyOutput(board.getEventsList);
  print(
      invoker['Pick event and cut for word without numbers'](board.events, 1));
  // invoker['Delete an event'](board, 0);
  handleRemovingEvent(board, 0);

  print("Was deleted");
  serviceForPretifyOutput(board.getEventsList);
}
