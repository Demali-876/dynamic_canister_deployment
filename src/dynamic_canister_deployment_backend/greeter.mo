import Principal "mo:base/Principal";
actor class Greeter(owner :Principal) {
    public query func greet(name : Text) : async Text {
        return "Hello, " # name # "!" # Principal.toText(owner) # "is my owner" ;
    };
}