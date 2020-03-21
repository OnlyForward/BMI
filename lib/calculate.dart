class Calculate {
  static final Calculate _calculate = Calculate._internal();
  String _status;
  double _index;

  double get index => _index;
  String get status => _status;

  set index(double index) => _index = index;
  set status(String status) => _status = status;

  factory Calculate() {
    return _calculate;
  }

  Calculate._internal();
}