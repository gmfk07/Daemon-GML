global.topics = {};

// First NPC
global.topics[$ "Hey there"] = [
	TEXT("Hey there, new player!")
];

global.topics[$ "Welcome"] = [
	TEXT("Hello! I welcome your digitized consciousness to the World of Daemon!"),
	TEXT("This virtual world has a lot to offer you, kid, but we gotta start with the basics."),
	TEXT("Select your team of 3 starting daemons from the beginner's selection provided by each studio!")
];

global.topics[$ "Welcome 2"] = [
	TEXT("Hm... solid choices!"),
	CHOICE("Now... are you ready to proceed into the vast and spectacular World of Daemon?",
		OPTION("Yeah!", "Welcome 3"),
		OPTION("Sorry, who are you?", "Welcome 4"))
];

global.topics[$ "Welcome 3"] = [
	TEXT("Yeah! Get PUMPED about daemon battling!"),
	TEXT("Each daemon is an AI program, designed by players like you and me. There are 6 classes of daemon, each maintained by a studio."),
	GOTO("Welcome 5")
];

global.topics[$ "Welcome 4"] = [
	TEXT("The name's Atu! I spend my time as a guide for new players."),
	TEXT("Why? Because someday someone I helped is going to go all the way to the very top in the world of daemon battling! And then they'll remember old Atu when the time comes to send invites for the admin parties and the early access daemon betas..."),
	TEXT("And I got a good feeling about you, kid!"),
	GOTO("Welcome 5")
];

global.topics[$ "Welcome 5"] = [
	TEXT("Anyways! Come follow me to the next room!")
];

global.topics[$ "Post-welcome"] = [
	TEXT("Hello again! Atu here with another hot tip: that guy you just battled? That gave enough xp to level up your daemons! You should equip the new cards you got into your decks."),
	CHOICE("Just hit tab to open your daemon menu, then right-click a daemon to access its moveset. Then add or remove the cards you want! Friendly warning though - your deck size must be at least three times your daemon's hand size.",
		OPTION("Thanks!", "Post-welcome 2"),
		OPTION("Who was that guy?", "Post-welcome 3"))
];

global.topics[$ "Post-welcome 2"] = [
	TEXT("No problem!"),
];

global.topics[$ "Post-welcome 3"] = [
	TEXT("Oh boy, you're gonna have to get used to battles from... eccentric people. Most of the World of Daemon is a PvP zone, after all.")
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