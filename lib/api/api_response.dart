class ApiResponse<T> {
  bool? ok;
  String? msg;
  T? result;

  ApiResponse(this.result, this.msg, this.ok);

  ApiResponse.ok(this.result) {
    ok = true;
  }

  ApiResponse.error(this.msg) {
    ok = false;
  }
}
