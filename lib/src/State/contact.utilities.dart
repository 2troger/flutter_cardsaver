import 'package:quiver/strings.dart';
import 'package:testapp/src/models.dart';

Vision processValues(Vision vision, List<String> values) {
  for (var value in values) {
    var match =
        RegExp(Vision.regexName, caseSensitive: false).stringMatch(value);
    if (!isBlank(match) && !vision.names.contains(match)) {
      vision.names.add(match);
    }
    match = RegExp(Vision.regexEmail, caseSensitive: false).stringMatch(value);
    if (!isBlank(match) && !vision.emails.contains(match)) {
      vision.emails.add(match);
    }
    match = RegExp(Vision.regexPhone, caseSensitive: false).stringMatch(value);
    if (!isBlank(match) && !vision.phones.contains(match)) {
      vision.phones.add(match);
    }
    match =
        RegExp(Vision.regexWebsite, caseSensitive: false).stringMatch(value);
    if (!isBlank(match) && !vision.websites.contains(match)) {
      vision.websites.add(match);
    }
    match =
        RegExp(Vision.regexAddress, caseSensitive: false).stringMatch(value);
    if (!isBlank(match) && !vision.addresses.contains(match)) {
      vision.addresses.add(match);
    }
    match =
        RegExp(Vision.regexAltAddress, caseSensitive: false).stringMatch(value);
    if (!isBlank(match) && !vision.altAddresses.contains(match)) {
      vision.altAddresses.add(match);
    }
    match =
        RegExp(Vision.regexCszAddress, caseSensitive: false).stringMatch(value);
    if (!isBlank(match) && !vision.cszAddresses.contains(match)) {
      vision.cszAddresses.add(match);
    }
  }
  return vision;
}
