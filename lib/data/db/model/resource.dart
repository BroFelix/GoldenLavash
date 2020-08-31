import 'package:floor/floor.dart';

@Entity(tableName: 'Resource')
class Resource {
  Resource({
    this.id,
    this.title,
    this.editType,
    this.resourceType,
  });

  @primaryKey
  int id;
  String title;
  int editType;
  String resourceType;

  Resource copyWith({
    int id,
    String title,
    int editType,
    String resourceType,
  }) =>
      Resource(
        id: id ?? this.id,
        title: title ?? this.title,
        editType: editType ?? this.editType,
        resourceType: resourceType ?? this.resourceType,
      );

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        id: json["id"],
        title: json["title"],
        editType: json["edit_type"],
        resourceType: json["resource_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "edit_type": editType,
        "resource_type": resourceType,
      };
}
