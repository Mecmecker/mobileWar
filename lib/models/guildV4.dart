import 'dart:convert';

class Guild {
  final GuildClass guild;

  Guild({
    required this.guild,
  });

  factory Guild.fromRawJson(String str) => Guild.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Guild.fromJson(Map<String, dynamic> json) => Guild(
        guild: GuildClass.fromJson(json["guild"]),
      );

  Map<String, dynamic> toJson() => {
        "guild": guild.toJson(),
      };
}

class GuildClass {
  final String name;
  final String world;
  final int playersOnline;
  final int playersOffline;
  final int membersTotal;
  final List<Member> members;

  GuildClass({
    required this.name,
    required this.world,
    required this.playersOnline,
    required this.playersOffline,
    required this.membersTotal,
    required this.members,
  });

  factory GuildClass.fromRawJson(String str) =>
      GuildClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GuildClass.fromJson(Map<String, dynamic> json) => GuildClass(
        name: json["name"],
        world: json["world"],
        playersOnline: json["players_online"],
        playersOffline: json["players_offline"],
        membersTotal: json["members_total"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "world": world,
        "players_online": playersOnline,
        "players_offline": playersOffline,
        "members_total": membersTotal,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
      };
}

class Member {
  final String name;
  final String title;
  final Rank rank;
  final Vocation vocation;
  final int level;
  final DateTime joined;
  final StatusEnum status;

  Member({
    required this.name,
    required this.title,
    required this.rank,
    required this.vocation,
    required this.level,
    required this.joined,
    required this.status,
  });

  factory Member.fromRawJson(String str) => Member.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        name: json["name"],
        title: json["title"],
        rank: rankValues.map[json["rank"]]!,
        vocation: vocationValues.map[json["vocation"]]!,
        level: json["level"],
        joined: DateTime.parse(json["joined"]),
        status: statusEnumValues.map[json["status"]]!,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "rank": rankValues.reverse[rank],
        "vocation": vocationValues.reverse[vocation],
        "level": level,
        "joined":
            "${joined.year.toString().padLeft(4, '0')}-${joined.month.toString().padLeft(2, '0')}-${joined.day.toString().padLeft(2, '0')}",
        "status": statusEnumValues.reverse[status],
      };
}

enum Rank { LEADER, MEMBER, TWIST, VICE_LEADER }

final rankValues = EnumValues({
  "Leader": Rank.LEADER,
  "(member)": Rank.MEMBER,
  "Twist": Rank.TWIST,
  "Vice Leader": Rank.VICE_LEADER
});

enum StatusEnum { OFFLINE, ONLINE }

final statusEnumValues =
    EnumValues({"offline": StatusEnum.OFFLINE, "online": StatusEnum.ONLINE});

enum Vocation {
  DRUID,
  ELDER_DRUID,
  ELITE_KNIGHT,
  KNIGHT,
  MASTER_SORCERER,
  NONE,
  PALADIN,
  ROYAL_PALADIN,
  SORCERER
}

final vocationValues = EnumValues({
  "Druid": Vocation.DRUID,
  "Elder Druid": Vocation.ELDER_DRUID,
  "Elite Knight": Vocation.ELITE_KNIGHT,
  "Knight": Vocation.KNIGHT,
  "Master Sorcerer": Vocation.MASTER_SORCERER,
  "None": Vocation.NONE,
  "Paladin": Vocation.PALADIN,
  "Royal Paladin": Vocation.ROYAL_PALADIN,
  "Sorcerer": Vocation.SORCERER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
