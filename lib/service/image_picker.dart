import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class ImageHelperService extends BaseViewModel {
  ImagePicker imagePicker = ImagePicker();

  pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 100,
  }) async {
    return await imagePicker.pickImage(
      source: source,
      imageQuality: imageQuality,
    );
  }
}
