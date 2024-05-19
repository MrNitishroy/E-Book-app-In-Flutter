
class NotificationModel {
  String? id;
  String? title;
  String? des;
  String? startingTime;
  String? endingTime;

  NotificationModel({this.id, this.title, this.des, this.startingTime, this.endingTime});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    des = json["des"];
    startingTime = json["startingTime"];
    endingTime = json["endingTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["des"] = des;
    _data["startingTime"] = startingTime;
    _data["endingTime"] = endingTime;
    return _data;
  }
}