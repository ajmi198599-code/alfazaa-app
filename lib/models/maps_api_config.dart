class MapsApiConfig {
  const MapsApiConfig._();

  static const String googleMapsApiKey =
      String.fromEnvironment('GOOGLE_MAPS_API_KEY');
  static const bool googleMapsEnabled =
      bool.fromEnvironment('ALFAZAA_GOOGLE_MAPS_ENABLED');

  static const List<String> preparedApis = [
    'Maps JavaScript API',
    'Maps SDK for Android',
    'Maps SDK for iOS',
    'Places API',
    'Geolocation preparation',
    'Directions API preparation',
  ];

  static const List<String> webLibraries = ['places', 'marker'];
}
