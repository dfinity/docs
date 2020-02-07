import Debug "mo:stdlib/debug";
actor HelloActor {
   public query func hello() : async () {
      Debug.print ("Hello, World from DFINITY \n");
   }
};
