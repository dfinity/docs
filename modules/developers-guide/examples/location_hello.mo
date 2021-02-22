actor {
  public func location(city : Text) : async Text {
    return "Hello, " # city # "!";
  };
};