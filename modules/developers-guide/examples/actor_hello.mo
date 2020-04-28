import Debug "mo:base/Debug";
actor HelloActor {
   public query func hello() : async () {
      Debug.print ("Hello, World from DFINITY \n");
   }
};
