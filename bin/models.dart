import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';

// Data structers
class User {
  String _name;
  String _surname;
  int _age;
  int _toDayTimeLimit;

  User(String userName, String secondName, int age, [var time])
      : _name = userName,
        _surname = secondName,
        _age = age {
    _toDayTimeLimit = time ?? (age * 100 / 24).round();
  }

  set name(firstName) => _name = firstName;

  String get name => _name;

  @override
  String toString() {
    return '${_name} ${_surname}';
  }
}

class Event {
  String title;
  String description;
  DateTime startingTime;
  Duration timeForWork;

  Event(this.title, this.description, this.startingTime, this.timeForWork);

  @override
  String toString() {
    // TODO: implement toString
    return '${title} ${description} start at ${DateFormat('jms').format(startingTime)}';
  }
}

class Board {
  Set<User> users;
  List<Event> events;
  // Map<String, List<String>> usersEvents;
  Map<User, List<Event>> usersEvents;

  Board() {
    users = Set();
    events = [];
    usersEvents = {};
  }

  set setEventsList(Map map) {
    usersEvents.addAll(map);
  }

  Map get getEventsList => usersEvents;

  set setUsers(User user) {
    users.add(user);
    usersEvents[user] = [];
  }

  Set get getUsers => users;

  set setEvents(Event event) {
    events.add(event);
    usersEvents[users.last].add(event);
  }

  List get getEvents => events;
}
