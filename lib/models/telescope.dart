import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shop_a_z/models/brand.dart';
import 'package:shop_a_z/models/image_model.dart';

part 'telescope.freezed.dart';

part 'telescope.g.dart';

@unfreezed
class Telescope with _$Telescope {
    @JsonSerializable(explicitToJson: true)
  factory Telescope(
      {String? id,
      required String model,
      required Brand brand,
      required String type,
      required String dimension,
      required num weightInPound,
      required String focustype,
      required num lensDiameterInMM,
      required String mountDescription,
      required num price,
      required num stock,
      @Default(0.0) num avgRating,
      @Default(0) num discount,
      required ImageModel thumbnail,
      required List<ImageModel> additionalImage,
      String? description}) = _Telescope;

  factory Telescope.fromJson(Map<String, dynamic> json) =>
      _$TelescopeFromJson(json);
}
