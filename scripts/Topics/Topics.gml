global.topics = {};

global.topics[$ "Welcome"] = [
	TEXT("Hello! Welcome to the World of Daemon!"),
	TEXT("Select your team of 3 starting daemons from the beginner's selection provided by each studio!")
];

global.topics[$ "Example1"] = [
	TEXT("What's up gamer?"),
	TEXT("Let's go"),
	TEXT("EEEEEEEEEEE EEEEEEEEEEEEE EEEEEEEEEEEEEEEEEEEE oh my god I hope this works out"),
	CHOICE("What's new pussycat?",
		OPTION("WHOAAAAHOOAO", "correct pussycat"),
		OPTION("shut up", "incorrect pussycat"))
];

global.topics[$ "Example2"] = [
	TEXT("Now this is the serious part"),
	TEXT("Conversation over")
];

global.topics[$ "correct pussycat"] = [
	TEXT("Very nice"),
	EVENTFLAG("correct")
];

global.topics[$ "incorrect pussycat"] = [
	TEXT("No... cmon, sing along!"),
	GOTO("Example")
];

global.topics[$ "battle npc 1 battle"] = [
	TEXT("Hey noob nice team you got there haha"),
	TEXT("Unfortunately for you, you've entered my detection radius... I challenge you to a battle!"),
	TEXT("Beating new players is great XP!")
];

global.topics[$ "battle npc 1 defeated"] = [
	TEXT("Hey! You're not supposed to beat me!"),
	TEXT("How embarassing... losing to a brand new player...")
];

global.topics[$ "battle npc 1 dialogue"] = [
	TEXT("You got lucky, kid...")
];