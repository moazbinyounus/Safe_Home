class TempModel{
  final String temp;
  final String time;
  TempModel(this.time,this.temp);
  TempModel.fromMap(Map<String,dynamic> map)
  :assert(map['temp'] != null),
        assert(map['time'] != null),
        temp=map['temp'],
        time=map['time'];

  @override
  String toString() {
    return "Record<$temp:$time>";
  }
}