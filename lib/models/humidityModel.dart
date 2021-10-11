class HumidityModel{
  final String humidity;
  final String time;
  HumidityModel(this.time,this.humidity);
  HumidityModel.fromMap(Map<String,dynamic> map)
      :assert(map['humidity'] != null),
        assert(map['time'] != null),
        humidity=map['humidity'],
        time=map['time'];

  @override
  String toString() {
    return "Record<$humidity:$time>";
  }
}