/// A generic class that holds a value of Api result.
/// [T] The type of data hold by this instance
class ApiResult<T> {
  T? success;
  int errorCode;
  String? errorMessage;

  ApiResult({this.success, this.errorCode = 0, this.errorMessage});
}
