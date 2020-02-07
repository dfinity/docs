actor rock_paper_scissors {

	var alice_score: Nat = 0;
    var bob_score: Nat = 0;
    var alice_last: Choice = { #scissors };
    var bob_last: Choice = { #rock };

	type Choice = {
		#rock;
		#paper;
		#scissors;
	};

    public func contest() : async Text {
		for (i in range(0,99)) {
			battle_round();
		};
        var winner = "The contest was a draw";
		if (alice_score > bob_score) winner := "Alice won" 
		else if (alice_score < bob_score) winner := "Bob won";
        return (winner);
	};

    func battle_round() : () {
     	let a = alice(bob_last);
	    let b = bob(alice_last);

	  switch (a,b) {
		case (#rock,#scissors) alice_score +=1;
		case (#rock,#paper) bob_score +=1;
		case (#paper,#scissors) alice_score +=1;
		case (#paper,#rock) bob_score +=1;
		case (#scissors,#paper) alice_score +=1;
		case (#scissors,#rock) bob_score +=1;
	  };

	  alice_last := a;
	  bob_last := b;

	  return ();
};
      // Hard-coded players and choices
      func bob(last: Choice) : Choice {
    	return #paper;
      };

      func alice(last: Choice) : Choice {
    	return #rock;
	  };
};
