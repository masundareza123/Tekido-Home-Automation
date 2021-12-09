class PairedDevice{
  int? id;
  String inputGuid = '';
  String outputGuid = '';
  String inputName = '';
  String outputName = '';
  String inputQty = '';
  String outputQty = '';

  PairedDevice(
      // this.id,
      this.inputGuid,
      this.outputGuid,
      this.inputName,
      this.outputName,
      this.inputQty,
      this.outputQty,
      );

  PairedDevice.fromMap(Map<String, dynamic> device){
    this.id = device["id"];
    this.inputGuid = device["inputGuid"];
    this.outputGuid = device["outputGuid"];
    this.inputName = device["inputName"];
    this.outputName = device["outputName"];
    this.inputQty = device['inputQty'];
    this.outputQty = device['outputQty'];
  }

  Map<String, dynamic> toMap() => {
    'id' : id,
    'inputGuid' : inputGuid,
    'outputGuid' : outputGuid,
    'inputName' : inputName,
    'outputName' : outputName,
    'inputQty' : inputQty,
    'outputQty' : outputQty,
  };
}