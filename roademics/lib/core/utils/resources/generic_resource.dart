sealed class GenericResource<T> {
  final T? data;
  final String? message;

  const GenericResource({this.data, this.message});
}

class Success<T> extends GenericResource<T> {
  const Success(T data) : super(data: data);
}

class Error<T> extends GenericResource<T> {
  const Error(String message, {super.data}) : super(message: message);
}
