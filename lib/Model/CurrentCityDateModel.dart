class CurrentCityDateModel {
  final String _cityname;
  final double _lon;
  final double _lot;
  final String _main;
  final String _description;
  final double _temp;
  final double _temp_min;
  final double _temp_max;
  final int _pressure;
  final int _humidity;
  final double _windspeed;
  final int _datetime;
  final String _country;
  final int _sunset;
  final int _sunrise;

  CurrentCityDateModel(
      this._cityname,
      this._lon,
      this._lot,
      this._main,
      this._description,
      this._temp,
      this._temp_min,
      this._temp_max,
      this._pressure,
      this._humidity,
      this._windspeed,
      this._datetime,
      this._country,
      this._sunset,
      this._sunrise) {}

  get sunrise => _sunrise;

  get sunset => _sunset;

  String get country => _country;

  get datetime => _datetime;

  get windspeed => _windspeed;

  get humidity => _humidity;

  get pressure => _pressure;

  get temp_max => _temp_max;

  get temp_min => _temp_min;

  get temp => _temp;

  String get description => _description;

  String get main => _main;

  get lot => _lot;

  get lon => _lon;
}
