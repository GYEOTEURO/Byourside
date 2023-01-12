class FirebaseUser {
  final String? uid;
  final String? code; //code firebaseauth excemption
  String? phoneNum;
  String? displayName;

  FirebaseUser({this.uid, this.code, this.phoneNum, this.displayName});
}
