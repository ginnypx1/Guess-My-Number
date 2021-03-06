// GAME VARIABLES
var my_num = Math.floor(Math.random() * 10) + 1;
var strikes = 0;

// GAME FUNCTION
$("button").click(function() {
	// grab input value
	var my_guess = $('input:text').val();
	// clear #hint1 & #hint2 fields
	$("#hint1").text(" ");
	$("#hint2").text(" ");
	// play a turn	
	if (my_num == my_guess) {
		// display win state
		$("#hint2").append("You Win! :)");
	} else if (strikes == 2) {
		// display loss state
		$("#hint1").append("You Lose! :(");
		$("#hint2").append("My number was " + my_num + ".");	
	} else {
		// guess again, higher or lower
		if (my_num > my_guess) {
			strikes += 1;
			$("#hint1").append("Strikes: " + strikes);
			$("#hint2").append("Hint: Guess Higher");
		} else {
			strikes += 1;
			$("#hint1").append("Strikes: " + strikes);
			$("#hint2").append("Hint: Guess Lower");
		} // end if/else (<>)
	} // end if/elseif/else (win/lose/keepgoing)
}); // end click function

$("#play-again").click(function() {
	location.reload(true);
}); // end click function