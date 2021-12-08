class PairedDevice{
  int? id;
  String inputGuid = '';
  String outputGuid = '';
  String inputName = '';
  String outputName = '';

  PairedDevice(
      // this.id,
      this.inputGuid,
      this.outputGuid,
      this.inputName,
      this.outputName
      );

  PairedDevice.fromMap(Map<String, dynamic> device){
    this.id = device["id"];
    this.inputGuid = device["inputGuid"];
    this.outputGuid = device["outputGuid"];
    this.inputName = device["inputName"];
    this.outputName = device["outputName"];
  }

  Map<String, dynamic> toMap() => {
    'id' : id,
    'inputGuid' : inputGuid,
    'outputGuid' : outputGuid,
    'inputName' : inputName,
    'outputName' : outputName
  };
}