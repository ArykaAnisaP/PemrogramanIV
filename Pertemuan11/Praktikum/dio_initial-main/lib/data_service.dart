import 'user.dart';

class DataService {
  Future getUsers() async {}

  Future postUser(String name, String job) async {}

  Future putUser(String idUser, String name, String job) async {}

  Future deleteUser(String idUser) async {}

  Future<Iterable<User>?> getUserModel() async {
    return [];
  }
}
