
class ModeData {
  String modeName;
  String modeDescription;
  String image;
  int selfModeStartIndex;
  int selfModeEndIndex;
  int peakShavingChargeStart1Index;
  int peakShavingChargeEnd1Index;
  int peakShavingDischargeStart1Index;
  int peakShavingDischargeEnd1Index;
  int peakShavingChargeStart2Index;
  int peakShavingChargeEnd2Index;
  int peakShavingDischargeStart2Index;
  int peakShavingDischargeEnd2Index;

  ModeData({
    required this.modeName,
    required this.modeDescription,
    required this.image,
    this.selfModeStartIndex = -1,
    this.selfModeEndIndex = -1,
    this.peakShavingChargeStart1Index = -1,
    this.peakShavingChargeEnd1Index = -1,
    this.peakShavingDischargeStart1Index = -1,
    this.peakShavingDischargeEnd1Index = -1,
    this.peakShavingChargeStart2Index = -1,
    this.peakShavingChargeEnd2Index = -1,
    this.peakShavingDischargeStart2Index = -1,
    this.peakShavingDischargeEnd2Index = -1,
  });

  ModeData copyWith({
    String? modeName,
    String? modeDescription,
    String? image,
    int? selfModeStartIndex,
    int? selfModeEndIndex,
    int? peakShavingChargeStart1Index,
    int? peakShavingChargeEnd1Index,
    int? peakShavingDischargeStart1Index,
    int? peakShavingDischargeEnd1Index,
    int? peakShavingChargeStart2Index,
    int? peakShavingChargeEnd2Index,
  }) {
    return ModeData(
      modeName: modeName ?? this.modeName,
      modeDescription: modeDescription ?? this.modeDescription,
      image: image ?? this.image,
      selfModeStartIndex: selfModeStartIndex ?? this.selfModeStartIndex,
      selfModeEndIndex: selfModeEndIndex ?? this.selfModeEndIndex,
      peakShavingChargeStart1Index: peakShavingChargeStart1Index ?? this.peakShavingChargeStart1Index,
      peakShavingChargeEnd1Index: peakShavingChargeEnd1Index ?? this.peakShavingChargeEnd1Index,
      peakShavingDischargeStart1Index: peakShavingDischargeStart1Index ?? this.peakShavingDischargeStart1Index,
      peakShavingDischargeEnd1Index: peakShavingDischargeEnd1Index ?? this.peakShavingDischargeEnd1Index,
      peakShavingChargeStart2Index: peakShavingChargeStart2Index ?? this.peakShavingChargeStart2Index,
      peakShavingChargeEnd2Index: peakShavingChargeEnd2Index ?? this.peakShavingChargeEnd2Index,
    );
  }
}