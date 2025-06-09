import 'package:template/core/utils/result.dart';

class Page1Repository {
  Result<List<String>> getData([bool throwError = false]) {
    if (throwError) {
      return ResultError<List<String>>('An error occurred');
    }
    return ResultData(List.generate(3, (index) => 'Item $index'));
  }
}
