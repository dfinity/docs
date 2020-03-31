import Debug "mo:stdlib/Debug";
actor HelloActor {
   public query func hello() : async () {
      Debug.print ("Hello, World from DFINITY \n");
   }
};
