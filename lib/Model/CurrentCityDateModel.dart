class CurrentCityDateModel {
  final String _cityname;
  final String _lon;
  final String _lot;
  final String _main;
  final String _description;
  final String _temp;
  final String _temp_min;
  final String _temp_max;
  final String _pressure;
  final String _humidity;
  final String _windspeed;
  final String _datetime;
  final String _country;
  final String _sunset;
  final String _sunrise;

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
