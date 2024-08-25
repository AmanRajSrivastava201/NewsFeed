/// This is a interface class for all request model to provide Json converter functionality.
abstract class JsonConverters {
  /// This method will be implemented by it's child class to provide converter from model to data.
  Map<String, dynamic> toJson();
}
