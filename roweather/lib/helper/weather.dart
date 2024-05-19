enum Weather { sunny, fullCloudy, partialCloudy, rainy }

final parseWeatherCode = {
  0: Weather.sunny, // Unknown
  1000: Weather.sunny, // Clear, Sunny
  1100: Weather.sunny, // Mostly Clear
  1101: Weather.partialCloudy, // Partly Cloudy
  1102: Weather.fullCloudy, // Mostly Cloudy
  1001: Weather.fullCloudy, // Cloudy
  2000: Weather.fullCloudy, // Fog
  2100: Weather.fullCloudy, // Light Fog
  4000: Weather.rainy, // Drizzle
  4001: Weather.rainy, // Rain
  4200: Weather.rainy, // Light Rain
  4201: Weather.rainy, // Heavy Rain
  5000: Weather.rainy, // Snow
  5001: Weather.rainy, // Flurries
  5100: Weather.rainy, // Light Snow
  5101: Weather.rainy, // Heavy Snow
  6000: Weather.rainy, // Freezing Drizzle
  6001: Weather.rainy, // Freezing Rain
  6200: Weather.rainy, // Light Freezing Rain
  6201: Weather.rainy, // Heavy Freezing Rain
  7000: Weather.rainy, // Ice Pellets
  7101: Weather.rainy, // Heavy Ice Pellets
  7102: Weather.rainy, // Light Ice Pellets
  8000: Weather.rainy, // Thunderstorm
};