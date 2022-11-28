import 'package:hive/hive.dart';
part 'play_list_model.g.dart';

@HiveType(typeId: 1)
class PlayListerModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> songIds;
  PlayListerModel({
    required this.name,
    required this.songIds,
  });

  add(int id) async {
    songIds.add(id);
    save();
  }

  deletData(int id) {
    songIds.remove(id);
    save();
    
  }

  bool isValueIn(int id) {
    return songIds.contains(id);
  }
}
