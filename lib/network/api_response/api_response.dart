enum StatusEnum { loading, completed, error, internet }

class ApiResponse<T> {
  StatusEnum? statusEnum;
  T? data;
  String? message;

  ApiResponse({this.statusEnum, this.data, this.message});

  ApiResponse.loading() : statusEnum = StatusEnum.loading;

  ApiResponse.completed(this.data) : statusEnum = StatusEnum.completed;

  ApiResponse.error(this.message) : statusEnum = StatusEnum.error;

  ApiResponse.internet(this.message) : statusEnum = StatusEnum.internet;

  @override
  String toString() {
    return "Status : $statusEnum \n Message : $message \n Data: $data";
  }
}
