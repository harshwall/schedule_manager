class Person{
  String _name;
  String _docId;

  Person(this._name, this._docId);
  Person.blank();

  String get docId => _docId;

  set docId(String value) {
    _docId = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Map<String,String> toMap(){
    var map=Map<String,String>();
    map['name']=this.name;
    return map;
  }

  Person.fromMapObject(Map<String,dynamic> map){
    this.name=map['name'];
  }
}