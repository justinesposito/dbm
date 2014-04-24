--- Justin Esposito Final Project
--- NA LCS Database

DROP TABLE IF EXISTS teams;
CREATE TABLE teams(
	teamName text NOT NULL PRIMARY KEY,
	teamTAG text NOT NULL,
	teamHistory text NOT NULL
);

CREATE TYPE position as ENUM('Top Lane','AD Carry', 'Mid Lane', 'Jungler', 'Support');
DROP TABLE IF EXISTS players;
CREATE TABLE players(
	IGN text NOT NULL PRIMARY KEY,
	teamName text NOT NULL,
	fName text NOT NULL,
	lName text NOT NULL,
	position text NOT NULL,
	dob  date NOT NULL,
	contract_end date,
	playerBackground text NOT NULL,
	FOREIGN KEY (teamName) REFERENCES teams(teamName)
);

DROP TABLE IF EXISTS champions;
CREATE TABLE champions(
	name text NOT NULL PRIMARY KEY
);

DROP TABLE IF EXISTS schedule;
CREATE TABLE schedule(
	matchID int NOT NULL PRIMARY KEY,
	matchDT timestamp NOT NULL,
	team1 text NOT NULL,
	team2 text NOT NULL,
	winner text,
	FOREIGN KEY (team1) REFERENCES teams(teamName),
	FOREIGN KEY (team2) REFERENCES teams(teamName),
	FOREIGN KEY (winner) REFERENCES teams(teamName)
);

DROP TABLE IF EXISTS items;
CREATE TABLE items(
	itemID int NOT NULL PRIMARY KEY,
	itemName text NOT NULL,
	health int,
	mana int,
	healthPer5 int,
	manaPer5 int,
	CDR int, 
	armor int,
	mr int,
	ad int,
	ap int,
	atkspd int,
	critchance int,
	lifesteal int,
	spellvamp int,
	ms int,
	costGold int check (costGold> -1),
	itemCountMax int check (itemCountMax > 0),
	isStackable boolean NOT NULL
);

DROP TABLE IF EXISTS passives_actives;
CREATE TABLE passives_actives(
	passiveID int NOT NULL,
	itemID int NOT NULL,
	description text NOT NULL,
	isActive boolean NOT NULL,
	consumesOnActive boolean,
	isUnique boolean NOT NULL,
	cooldown int check (cooldown >= 0),
	PRIMARY KEY(passiveID, itemID),
	FOREIGN KEY (itemID) REFERENCES items(itemID)
);


DROP TABLE IF EXISTS player_stats;
CREATE TABLE player_stats(
	IGN text NOT NULL,
	matchID int NOT NULL,
	champion text NOT NULL,
	kills int NOT NULL,
	deaths int NOT NULL,
	assists int NOT NULL,
	creepScore int NOT NULL,
	goldEarned int NOT NULL,
	item1 int,
	item2 int,
	item3 int,
	item4 int,
	item5 int,
	item6 int,
	trinket int,
	PRIMARY KEY(IGN, matchID),
	FOREIGN KEY (IGN) REFERENCES players(ign),
	FOREIGN KEY (champion) REFERENCES champions(name),
	FOREIGN KEY (matchID) REFERENCES schedule(matchID),
	FOREIGN KEY (item1) REFERENCES ITEMS(itemID),
	FOREIGN KEY (item2) REFERENCES ITEMS(itemID),
	FOREIGN KEY (item3) REFERENCES ITEMS(itemID),
	FOREIGN KEY (item4) REFERENCES ITEMS(itemID),
	FOREIGN KEY (item5) REFERENCES ITEMS(itemID),
	FOREIGN KEY (item6) REFERENCES ITEMS(itemID),
	FOREIGN KEY (trinket) REFERENCES ITEMS(itemID)
);

DROP TABLE IF EXISTS team_stats;
CREATE TABLE team_stats(
	matchID int NOT NULL,
	teamName text NOT NULL,
	gameLength time NOT NULL,
	towersTaken int NOT NULL,
	dragonsTaken int NOT NULL,
	baronsTaken int NOT NULL,
	PRIMARY KEY (matchID, teamName),
	FOREIGN KEY (matchID) REFERENCES schedule(matchID),
	FOREIGN KEY (teamName) REFERENCES teams(teamName)
);

DROP TABLE IF EXISTS itemPaths;
CREATE TABLE itemPaths(
	itemID int not null,
	buildsFrom int not null,
	buildsFromCount int not null,
	primary key (itemid, buildsfrom),
	foreign key (itemID) references items(itemID),
	foreign key (buildsFrom) references items(itemID)
);


----------------------test data---------------------------------------


INSERT INTO teams(teamName, teamTag, teamHistory)
VALUES( 'Team Solomid', 'TSM', 'Widely considered as one of 
the top teams in North America, TSM eclipsed other teams in
 the region by consistently reaching the winners podium at 
 major events like IEM, MLG, IPL, and the NA Regionals.
After building up some of the biggest personalities in League
 of Legends through popular streams and a content-rich community 
 site, TSM used this visibility in tandem with their raw talent
  to develop one of the biggest names in the region.For the
   first time ever, TSM fell to the No. 2 spot behind Cloud 
   9 in the Season 3 summer split prompting them to adjust the 
   lineup with longtime leader, Reginald, stepping down from his 
   starting position in favor of the highly regarded Bjergsen. Still with 
   one of the longest standing rosters in the world and strong play across all positions, TSM is always a fan favorite.');

INSERT INTO teams(teamName, teamTag, teamHistory)
VALUES ( 'Counter-Logic Gaming', 'CLG', 'Counter Logic Gaming is 
one of the oldest teams in the League of Legends competitive 
scene. Beginning as a small group of friends with a passion 
for the game, they went on to win WCG 2010, one of the largest
 tournaments at the time. Since then, CLG has struggled to
  make it back to the top of LAN events. Several top players
   such as Cody "Elementz" Sigfusson, Brandon "Saintvicious" 
   DiMarco, Joedat "Voyboy" Esfahani, and Choi "Locodoco" 
   Yoon-sub have passed through their ranks and moved onto 
   other top teams.Over the past two NA LCS splits, 
   CLG fell down to the middle of the pack, dropping 
   into relegation matches for spring, and narrowly 
   avoiding the same fate in summer. Looking to refocus 
   for the 2014 season, CLG has made bold roster changes 
   once more as they attempt to find the right combination of players to relive their past glories.');

INSERT INTO teams(teamName, teamTAg, teamHistory)
VALUES ('Cloud 9', 'C9', 'Cloud 9 formed from the remnants of Orbit Gaming, the same team that failed to qualify
 for the Season 3 spring split (losing to Team Marn). Hai and LemonNation
 decided to stick with the team and overhaul it, adding Sneaky, Balls, and Meteos. The investment paid off, with a 
 convincing qualifier victory over compLexity which continued into the LCS. Cloud 9 took the Season 3 summer split 
 by storm with a dominant 25-3 record aided by Meteos league leading KDA and the duo of LemonNation and Sneaky introducing the Ashe/Zyra combination in the bot lane.
In the NA Regionals, Cloud 9 never lost a single game and locked in a bye into the Season 3 World Championships. But their postseason
 run was abruptly halted by a red-hot Fnatic squad as Cloud 9 bowed out of the tournament in a short-lived 1-2 series.
  They return to the 2014 season with a vengeance to improve on their disappointing finish.');

INSERT INTO teams(teamName, teamTAg, teamHistory)
VALUES ('Team Coast', 'Coast', 'Team Coast engineered one of the biggest comebacks in LCS history; after their rocky 1-10 start,
 the mid-season decision to add Miles "Daydreamin" Hoard to the support role played a pivotal role in their rise to become the 
 No. 2 team in North America during the spring split. However, during the summer split, they fell all the way to the seventh seed.
  Having experienced both highs and lows, a re-energized Team Coast blasted their way through the NACL, boasting a 24-2 regular
   season record and also taking the crown at the end of the playoffs. New ace, WizfujiiN joins the team for 2014 as they look to
    improve on their past finishes.');
    
INSERT INTO teams(teamName, teamTag, TeamHistory)
VALUES ('Evil Geniuses', 'EG', 'Evil Geniuses is one of the largest esports organizations in the world and they have brought over
 their team from Europe to compete in the NA LCS. The squad formerly known as CLG.EU, took 4th place in the Season 2 World Championships 
 and barely missed out representing Europe in Season 3. With solo lane players Froggen and Wickd departing for Alliance, EG has tasked
  Innox and Pobelter to fill in the empty slots on the roster. Meanwhile, the combined experience of Snoopeh, Yellowpete, and Krepo
   should make a large impact in the upcoming season.');

INSERT INTO teams(teamName, teamTag, TeamHistory)
VALUES ('Team Dignitas', 'DIG', 'Formed in 2003, Team Dignitas has grown into a major gaming organization and when they picked up Rock
 Solid in 2011, they found subsequent success at IPL3. This success continued over in the Season 2 NA Regionals where they ended up 
 representing North America in the years world championships. A lackluster performance though, ended their hopes of a title and 
 inconsistency has plagued the team since. Missing out on the Season 3 World Championship was the tipping point, as freshly 
 recruited Cruzerthebruzer looks to make his first LCS debut in the top lane as KiWiKiD takes over Patoys position as the support.');

 INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
 VALUES ('Cruzerthebruzer', 'Team Dignitas', 'Cruz', 'Ogden', 'Top Lane', '01-03-1990', '10-20-2014', 'Cruzer joins the Dignitas lineup with a large void to fill. The team has 
 lacked an anchor in the top lane since the departure of Voyboy in mid-2012. Known for taking many risks in top lane, his play on 
 Lee Sin specifically warrants the attention of the opposing jungler which should free up the rest of Dignitas to make plays around 
 the map.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES('Crumbzz', 'Team Dignitas', 'Alberto', 'Rengifo', 'Jungler', '09-23-1992', '10-20-2014', ' Crumbzz’ story is characterized by versatility. He has played Mid Lane, Top Lane and Jungler competitively over his professional career and now finds himself back in the jungle.
Since his transition, he has trended towards bruiser champions that bring the threat of strong ganks, such as Lee Sin, Nocturne and Xin Zhao.
Crumbzz seeks an early game advantage in any way possible, by either enabling teammates or getting kills himself. His experience in multiple roles will serve him well when coordinating with his teammates and just might tip the scales in Dignitas’ favor.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Scarra', 'Team Dignitas', 'William', 'Li', 'Mid Lane', '04-12-1990', '10-20-2014', ' Wiliam "Scarra" Li is the backbone of Team Dignitas from the mid lane, having been with the team along with Imaqtpie since their original inception as ROCK SOLID. Although he was known for thriving with defensive champions such as Anivia or Karthus, Scarra has shown flexibility, spinning up his old favorites Katarina and Diana while practicing other similarly aggressive champions.
Scarra remains a crowd favorite due to his informative and popular stream; he has been used as an analyst for several major events such as the Season 2 World Championships. He will need to put his strategies to good use for the 2014 season.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Imaqtpie', 'Team Dignitas', 'Michael', 'Santana', 'AD Carry', '03-23-1992', '10-20-2014', 'With his signature long hair, Dignitas’ AD Carry Imaqtpie is instantly recognizable when sitting behind his team’s table. His skill with the Season 2 “holy trinity” of attack damage carry champions – Ezreal, Graves and Corki – was repeatedly illustrated in tournament play.
As one of Dignitas original pillars, Imaqtpie will need to carry his team through the 2014 season as they hope to climb back into the top rankings of North America.
');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Kiwikid', 'Team Dignitas', 'Alan', 'Nguyen', 'Support', '04-20-1994', '10-20-2014', ' Team Dignitas recruited KiWiKiD off the North American collegiate circuit, where he was previously playing for the University of Texas at Austin with an aggressive and pressure-centric playstyle that gained the respect of his teammates. Joining in December 2012 after the departure of IWillDominate, he had to ramp up quickly with his new team.
With Cruzerthebruzer moving into the Dignitas top lane, this has allowed KiWiKiD to transition into the bot lane where he will play support to the veteran Imaqtpie. Under his guidance, the two will be formidable foes heading into 2014.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('LemonNation', 'Cloud 9', 'Daerek', 'Hart', 'Support', '02-28-1990', '10-07-2015', 'Along with Hai, Daerek "LemonNation" Hart is one of the founding members of Cloud 9. Maintaining his original position as the teams Support, LemonNation became known in solo queue for reaching rank 1 during Season 2 playing only Support. As such a specialized player, LemonNation has shown a very strong champion pool including a uniquely-built AP Janna, Sona, Blitzcrank, Thresh, and Lulu. Always seen carrying Cloud 9s secret notebook, he was a significant factor in the Ashe/Zyra composition that dominated much of Season 3.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Sneaky', 'Cloud 9', 'Zachary', 'Scuderi', 'AD Carry', '06-06-1989', '10-07-2015', 'Once the AD Carry for Dignitass B Team, Zachary "Sneaky" Scuderi joined Cloud 9 after their former AD player Jason "WildTurtle" Tran was picked up by Team SoloMid. His play style is a great complement to LemonNations aggressive Support strategy. With a wide champion pool of AD Carries, he prefers to play Ezreal and Graves, but can also utilize less conventional carries such as Jayce in the bottom lane. He was a major contributor in the Ashe/Zyra lane that developed in Season 3s summer split. Outside of his role, he likes KhaZix for his sound set and Ziggs for his ability kit.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Hai', 'Cloud 9', 'Hai', 'Lam', 'Mid Lane', '07-20-1989', '10-07-2015', 'Hai "Hai" Lam is the veteran Mid Lane and team captain of Cloud 9, leading the team through several roster and name changes. Previously specializing in the jungle, he moved to the mid lane to increase his impact on the game tempo for his team. Hai has a strong preference toward assassins and bruisers with strong early game pressure and high potential to split push, such as Zed and KhaZix. But dont count Hai out as a niche player. He does exceptionally well with AP champions with immense map presence such as Twisted Fate and Gragas.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Meteoes', 'Cloud 9', 'William', 'Hartman', 'Jungler', '08-23-1992', '10-07-2015', 'Although William "Meteos" Hartman is the Jungler for Cloud 9, his favorite champion in the league is Twisted Fate because of his fast wave clear and global ganking presence. In the jungle, Meteos first became known as a high-level Skarner player, more recently transitioning to establish Nasus, Elise, and Zac as competitively viable Junglers. Having played many different roles in solo and normal queues, he originally settled in the jungle based on team need but would not play any other role in Season 3 because "laning is too hard." The Season 3 Regional MVP makes a return to 2014 to maintain his dominance and lead the charge of "carry" junglers.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Balls', 'Cloud 9', 'An', 'Le', 'Top Lane', '05-03-1994', '10-07-2015', ' As a former member of mTw.na (a past iteration of Vulcun), An "Balls" Le brings a long history of competitive experience to Cloud 9. His favorite champion is Ezreal, a preference retained from Season 1 when the pool of champions was much smaller and Ezreal offered a kit with fun skill shots. Balls is also known for his strong Rumble play as his placement of Equalizer never just equalizes the playing field, it tips it in his teams favor.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Doublelift', 'Counter-Logic Gaming', 'Yiliang', 'Peng', 'AD Carry', '03-12-1994', '10-19-2014', 'Widely regarded as one of the world’s best AD Carries, Yiliang "Doublelift" Pengs awe-inspiring performances in multiple tournaments have won him a large fan-following. CLG places great confidence in Doublelift’s abilities, often biding their time to allow him to gradually take over the game. A vital component to CLG’s hopes moving forward, his performances will undoubtedly be closely scrutinized in each and every game of the LCS.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Link', 'Counter-Logic Gaming', 'Austin', 'Shin', 'Mid Lane', '04-01-1994', '10-19-2014', 'Austin "Link" Shin replaced veteran member Bigfatlp in the mid lane during late December 2012 after just two weeks as his substitute. Suddenly thrown into the fierce competition of the North American LCS, Link quickly adapted using his previous experience from professional teams, utilizing his versatile playstyle to stay alive against some of the best Mid Lane players in the world. With many other roster adjustments, Link is now one of the oldest members left. He and CLG will seek to prove that the team can revitalize and work their way back to the top of the North American LCS.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Aphromoo', 'Counter-Logic Gaming', 'Zaqueri', 'Black', 'Support', '07-23-1992', '10-19-2014', ' Aphromoo previously the AD Carry for Team FeaR, now joins CLG as Doublelift’s Support once again, and with that, he brings a huge following and a wealth of experience in bot lane. Aphromoo’s preference for aggressive support champions coincides nicely with Doublelift’s AD Carry playstyle, frequently leading to early kills that snowball into complete lane dominance. Possessing quick decision making and a strong understanding of how and when to trade attacks, he brings a mechanically-oriented mind to CLG.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Nien', 'Counter-Logic Gaming', 'Zach', 'Malhas', 'Top Lane', '10-18-1994', '10-19-2014', 'As one of the best farmers in both solo queue and the competitive scene, Zach "Nien" Malhass strong mechanical skill can be attributed in part to his previous experience as a highly ranked Heroes of Newerth player. A credit to his prowess as an AD Carry, Nien was the first player in Season 3 to break 1000 League Points in the Challenger Tier.
During the Spring Split of the LCS, Nien left his position as Mid Laner for Cloud 9 to become the AD Carry for Team MRN.  For the Summer Split, he again transitioned both teams and roles in his movement to Top Lane for Counter Logic Gaming.  As one of the most versatile players in the professional scene, his adaptation to the new role will play a large part in CLGs success for this season.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Dexter', 'Counter-Logic Gaming', 'Marcel', 'Feldkamp', 'Jungler', '03-13-1993', '10-19-2014', 'Dexter makes the trek across the Atlantic, joining a star-studded CLG roster for the 2014 season. His strong mechanics in the jungle position gives the team a much-needed boost in a role that has been in dire straits for several months.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Nintendudex', 'Team Coast', 'Josh', 'Atkins', 'Jungler', '09-09-1994', '10-20-2014', 'The second oldest member of Team Coast, Joshua "NintendudeX" Atkins has been a consistent force to be reckoned with in the jungle since Monomaniac picked up the team in 2011. Citing personality issues, NintendudeX left the team in the summer of 2012, but just over a month later returned to lead the team to success at MLG Raleigh. Frequently drawing bans and counter-picks by enemies throughout the NA Qualifier, NintendudeX’s Olaf is world-renowned. When playing against other champions, his incredible split-push presence on Shen, powerful ganks on Jarvan and Elise, and unique builds on Fiddlesticks frequently empower his team to early leads and convincing victories.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('ZionSpartan', 'Team Coast', 'Darshan', 'Upadhyaha', 'Top Lane', '10-20-2014', '10-20-2014', 'The Top Lane for Team Coast, Darshan "ZionSpartan" Upadhyahas mobile play style frequently forces his opponents to react defensively. Excellent in 1v2 lane swaps, ZionSpartan’s adaptive talents make him a vital component of CST’s lineup. One of the two founding members of the team, he illustrated his fondness for assassin characters with his dominant Akali and Katarina play. ZionSpartan’s devastating performances with his favorite character Rumble render him an undeniable threat and he also boasts a potent Riven.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Daydreamin', 'Team Coast', 'Miles', 'Howard', 'Support', '07-30-1994', '10-20-2014', 'Miles "Daydreamin" Hoard first made his appearance as the Support for FXOpen e-Sports. While his stint with the team was short-lived, Daydreamin quickly became recognized as a reliable Support with unconventional tastes.
His addition to the team in the spring split helped carry them all the way to 2nd place in the postseason and he has already established that hes able to wield any support champions ranging from Blitzcrank to Yorick.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Shiphtur', 'Team Coast', 'Danny', 'Le', 'Mid Lane', '02-13-1993', '10-20-2014', 'Danny "Shiphtur" Le, Team Coasts Mid Lane, was one of the first to bring Ziggs into competitive play in the North American scene, drawing frequent bans in multiple tournaments. The first professional player to earn a visa to play in the United States, Shiphtur exhibits a deep champion pool, frequently swapping to unexpected champions with devastating effect. No longer an LCS-unknown, his high-profile playmaking will be put to the tested against the daunting competition in 2014.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Wizfujiin', 'Team Coast', 'Apollo', 'Price', 'AD Carry', '11-23-1994', '10-20-2014', 'Wizfujiin outperformed several competitors in Team Coasts search for a new AD Carry. Mechanically skilled combined great synergy with his support, Daydreamin, were huge factors in his selection. He helped lift Team Coast past the relegation matches against The Walking Zed and dominated all his opponents in the North America Challenger League, proving his worth.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Xpecial', 'Team Solomid', 'Alex', 'Chu', 'Support', '02-02-1993', '10-07-2015', 'Nicknamed "Hamster" by his teammates, Alex "Xpecial" Chu’s accommodating and quiet attitude masks a fierce competitor who thrives at the highest levels of competition. Often practicing against his teammates in the Top and Mid positions, Xpecial’s mastery of the Support position that makes him an invaluable addition to TSM’s roster and earned him a spot on NAs All-star roster. In addition, Xpecial’s champion guides and mentoring of aspiring Support players have greatly contributed to his team’s impressive portfolio of community involvement. Xpecial comes into the 2014 season as the most consistent player on the team and will need to continue his solid performances.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Wildturtle', 'Team Solomid', 'Jason', 'Tran', 'AD Carry', '12-20-1994', '10-07-2015', 'A player of many talents and even more smiles, Jason “WildTurtle” Tran takes on the mantle of TSM’s AD Carry. He brings a wide array of experience playing as both the AD Carry and Mid Lane for various teams. He first emerged onto the scene as a sub for Team Legion at IPL Face Off: San Francisco where he awed fans with his Gragas.
At MLG Raleigh, WildTurtle subbed once more, but this time for CLG Black and added Twisted Fate to his already impressive repertoire. Despite moving onto a slightly different role on TSM, WildTurtle garnered much attention from fans and critics everywhere when he debuted with a Pentakill. His skill only increased as he secured multiple slots on the NA Challenger Ladder and heading into 2014, he might be one of the strongest ADCs in the world.'); 

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('TheOddOne', 'Team Solomid', 'Brian', 'Wyllie', 'Jungler', ' 01-30-1992', '10-07-2015', 'The General, TheGodOne, OddBro. TSMs Jungler Brian "TheOddOne" Wyllie is a man of many names. One of the most popular players in League of Legends, TheOddOnes stream consistently attracts tens of thousands of viewers daily with his strategic explanations and stellar ability to command the jungle. TheOddOne pioneered the use of popular Junglers like Maokai and Nunu, and was widely considered one of the best Junglers in the world in Season 1. With his team focused on dominating the LCS, TheOddOne is a force to be reckoned with in the 2014 season.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Dyrus', 'Team Solomid', 'Marcus', 'Hill', 'Top Lane', '04-18-1994', '10-07-2015', 'There are few players that have been part of the League of Legends scene longer than TSMs Top laner Marcus "Dyrus" Hill. A sensation from the beta phase of LoL’s development and a former member of both Team All or Nothing and Epik Gamer, Dyrus skills have consistently been in demand. Famous for spamming /laugh while playing his beloved Singed, Dyrus has proven to be a versatile Top laner and aided in bringing champions like Jax and Vlad to the forefront of competitive play. When his dominant streak faltered on the global stage, Dyrus redoubled his efforts in preparation for the LCS.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Bjergsen', 'Team Solomid', 'Soren', 'Bjerg', 'Mid Lane', '11-11-1993', '10-07-2015', 'Søren "Bjergsen" Bjerg enters the 2014 season as one of the most hyped players in the NA LCS. A former superstar of the European powerhouse, Ninjas in Pyjamas, look for his Syndra and Zed to terrorize the NA LCS as he looks to propel TSM Snapdragon past their previous obstacles.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Krepo', 'Evil Geniuses', 'Mitch', 'Voorspoels', 'Support', '09-29-1990', '10-20-2014', 'The Support player of Evil Geniuses and member of the Analyst Desk at Season 3 Worlds, Krepo has described his synergy with his AD Carry Yellowpete as a “Yin and Yang” partnership. Known for unintentionally stealing his AD Carry’s kills, his teammates jokingly refer to him as “Scumbag Krepo”, a name now adopted by the community at large. Preferring to play aggressive support champions, he is best known for his terrifying Leona play. He admits that passive supports simply don’t fit his mentality, and that he tries to avoid them as much as possible.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES('Yellowpete', 'Evil Geniuses', 'Peter', 'Wuppen', 'AD Carry', '03-26-1990', '10-20-2014', 'Yellowpete is the stabilizing element of Evil Geniuses. A calm and composed player both in-game and during interviews, his level-headed demeanor was one of the major reasons why he was recruited in 2011. With years of prior experience playing with his support Krepo, Yellowpete is able to play unorthodox AD Carries like Varus and Urgot to deadly effect. With a well –developed champion pool, his famous Kog’Maw play has carried Evil Geniuses to victory on numerous occasions. Yellowpete’s innovation and veteran leadership will be keys to his team’s success in the LCS.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Snoopeh','Evil Geniuses', 'Stephen', 'Ellis', 'Jungler', '07-01-1991', '10-20-2014', 'Formerly a part of SK Gaming, Snoopeh is the celebrity face of Evil Geniuses. A relatively unknown player upon his entry to the competitive scene, he quickly evolved into one of the most famous streamers in Europe. A master of support-oriented junglers, he prioritizes perfect carry protection and frequently sacrifices his jungle resources for his teammates. With a controlled approach to his game, he continually analyzes his opponent’s strategies to predict the opposing Junglers movements and counter them. One of Snoopehs more memorable moments was the now-famous “The Snoopeh Stare”, which he performed at the Season 2 World Championships by staring into the camera as long as possible without blinking.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Innox', 'Evil Geniuses', 'Tyson', 'Kapler', 'Top Lane', '10-14-1993', '10-20-2014', 'InnoX, much like many other rookie LCS players, has competed on several teams before making it into the professional spotlight. His champion repertoire contains mechanically-dependent laners like Riven, Nidalee, and Lee Sin. With plenty of experience on amateur teams, its up to him to transfer those skills into the LCS.');

INSERT INTO players(IGN, teamName, fname, lName, position, dob, contract_end, playerBackground)
VALUES ('Pobelter', 'Evil Geniuses', 'Eugene', 'Park', 'Mid Lane', '12-01-1996', '10-20-2014', 'With playmaking abilities that leave his enemies completely outmatched, the high school sensation makes his LCS debut for Evil Genuises. Pobelter had spent most of his career jumping around teams, unable to play in the LCS due to age-restrictions but dominated the rest of the scene with champions such as Gragas, Orianna, and Riven.');

INSERT INTO champions(name)
VALUES('Volibear');

INSERT INTO champions(name)
VALUES('Renekton');

INSERT INTO champions(name)
VALUES('Shyvanna');

INSERT INTO champions(name)
VALUES('Dr. Mundo');

INSERT INTO champions(name)
VALUES('Trundle');

INSERT INTO champions(name)
VALUES('Jax');

INSERT INTO champions(name)
VALUES('Orianna');

INSERT INTO champions(name)
VALUES('Gragas');

INSERT INTO champions(name)
VALUES('Ahri');

INSERT INTO champions(name)
VALUES('Zed');

INSERT INTO champions(name)
VALUES('Yasuo');

INSERT INTO champions(name)
VALUES('LeBlanc');

INSERT INTO champions(name)
VALUES('Annie');

INSERT INTO champions(name)
VALUES('Leona');

INSERT INTO champions(name)
VALUES('Thresh');

INSERT INTO champions(name)
VALUES('Lulu');

INSERT INTO champions(name)
VALUES('Blitzcrank');

INSERT INTO champions(name)
VALUES('Lee Sin');

INSERT INTO champions(name)
VALUES('Nocturne');

INSERT INTO champions(name)
VALUES('Vi');

INSERT INTO champions(name)
VALUES('Elise');

INSERT INTO champions(name)
VALUES('Tristana');

INSERT INTO champions(name)
VALUES('Vayne');

INSERT INTO champions(name)
VALUES('Ezreal');

INSERT INTO champions(name)
VALUES('Caitlyn');

INSERT INTO champions(name)
VALUES('Lucian');

--INSERT INTO items(itemID, itemName, health, mana, healthper5, manaper5, armor, mr, ad, ap, costGold, itemCountMax, isStackable)

INSERT INTO items(itemID, itemName, health, healthPer5, costGold, itemCountMax, isStackable)
VALUES ('001', 'Dorans Shield', '80', '8', '440', '6', 'false');

INSERT INTO items(itemID, itemName, health, manaper5, ap, costGold, itemCountMax, isStackable)
VALUES ('002', 'Dorans Ring', '80', '5', '15', '440', '6', 'false');

INSERT INTO items(itemID, itemName, health, ad, costGold, itemCountMax, isStackable)
VALUES ('003', 'Dorans Blade', '80', '8', '440', '6', 'false');

INSERT INTO items(itemID, itemName, costGold, itemCountMax, isStackable)
VALUES ('004', 'Health Potion', '35', '5', 'true');

INSERT INTO items(itemID, itemName, costGold, itemCountMax, isStackable)
VALUES ('005', 'Mana Potion', '35', '5', 'true');

INSERT INTO items(itemID, itemName, costGold, itemCountMax, isStackable)
VALUES ('006', 'Sight Ward', '75', '3', 'true');

INSERT INTO items(itemID, itemName,  costGold, itemCountMax, isStackable)
VALUES ('007', 'Vision Ward', '100', '30', 'true');

INSERT INTO items(itemID, itemName, armor, costGold, itemCountMax, isStackable)
VALUES ('008', 'Cloth Armor', '15', '300', '6', 'false');

INSERT INTO items(itemID, itemName, mr, costGold, itemCountMax, isStackable)
VALUES ('009', 'Null-Magic Mantle', '15', '400', '6', 'false');

INSERT INTO items(itemID, itemName, ad, costGold, itemCountMax, isStackable)
VALUES ('010', 'Long Sword', '10', '360', '6', 'false');

INSERT INTO items(itemID, itemName, ad, costGold, itemCountMax, isStackable)
VALUES ('011', 'B.F. Sword', '45', '1450', '6', 'False');

INSERT INTO items(itemID, itemName, mr, ad, costGold, itemCountMax, isStackable)
VALUES ('012', 'Hexdrinker', '25', '20', '590', '6','false');

INSERT INTO items(itemID, itemName, armor, costGold, itemCountMax, isStackable)
VALUES ('013', 'Wardens Mail', '50', '400', '6', 'false');

INSERT INTO items(itemID, itemName, health, costGold, itemCountMax, isStackable)
VALUES ('014', 'Giants Belt', '380', '1000', '6', 'false');

INSERT INTO items(itemID, itemName, health, armor, costGold, itemCountMax, isStackable)
VALUES ('015', 'Randuins Armor', '500', '50', '1000', '6', 'false');

INSERT INTO items(itemID, itemName, health, costGold, itemCountMax, isStackable)
VALUES ('016', 'Ruby Crystal', '180', '400', '6', 'false');

INSERT INTO items(itemID, itemName, mana, costGold, itemCountMax, isStackable)
VALUES ('017', 'Sapphire Crystal', '100', '400', '6', 'false');

INSERT INTO items(itemID, itemName, health, ad, costGold, itemCountMax, isStackable)
VALUES ('018', 'Phage', '200', '20', '565', '6', 'false');

INSERT INTO items(itemID, itemName, ap, costGold, itemCountMax, isStackable)
VALUES ('019', 'Amplifying Tomb', '20', '435', '6', 'false');

INSERT INTO items(itemID, itemName, mana, ap, costGold, itemCountMax, isStackable)
VALUES ('020', 'Sheen', '200', '25', '365', '6', 'false');

INSERT INTO items(itemID, itemName, atkspd, costGold, itemCountMax, isStackable)
VALUES ('021', 'Dagger', '15', '400', '6', 'false');

INSERT INTO items(itemID, itemName, critchance, costGold, itemCountMax, isStackable)
VALUES ('022', 'Brawlers Gloves', '10', '400', '6', 'false');

INSERT INTO items(itemID, itemName, atkspd, critchance, ms, costGold, itemCountMax, isStackable)
VALUES ('023', 'Zeal', '18', '10', '5', '375', '6', 'false');

INSERT INTO items(itemID, itemName, health, mana, ad, ap, atkspd, critchance, ms, costGold, itemCountMax, isStackable)
VALUES ('024', 'Trinity Force', '250', '200', '30', '30', '30', '10', '8', '3', '6','false');

INSERT INTO items(itemID, itemName, ap, cdr, costGold, itemCountMax, isStackable)
VALUES ('025', 'Fiendish Codex', '30', '10', '385', '6', 'false');

INSERT INTO items(itemID, itemName, ap, cdr, spellvamp, costGold, itemCountMax, isStackable)
VALUES ('026', 'Will of the Ancients', '80', '10', '20', '480', '6', 'false');

INSERT INTO items(itemID, itemName, ap, spellvamp, costGold, itemCountMax, isStackable)
VALUES ('028', 'Hextech Revolver', '40', '12', '330', '6', 'false');

INSERT INTO items(itemID, itemName, ad, lifesteal, costGold, itemCountMax, isStackable)
VALUES ('027', 'Vamperic Scepter', '10', '10', '400', '6', 'false');

INSERT INTO items (itemID, itemName, costGold, itemCountMax, isStackable)
VALUES ('90', 'Warding Totem', '0', '1', 'false');

INSERT INTO items (itemID, itemName, costGold, itemCountMax, isStackable)
VALUES ('91', 'Scrying Orb', '0', '1', 'false');

INSERT INTO items (itemID, itemName, costGold, itemCountMax, isStackable)
VALUES ('92', 'Sweeping Lens', '0', '1', 'false');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, isUnique, cooldown)
VALUES ('1', '90', 'Places a  Stealth Ward that lasts 60 / 120 seconds (120 second cooldown). Limit 3 Stealth Wards on the map per player.', 'true', 'true', '120');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, isUnique, cooldown)
VALUES ('2', '91', 'Reveals small location within 1500 / 2500 range for 1 second (120 second cooldown). Enemy champions hit will be revealed for 5 seconds. This does not affect stealth champions.', 'true', 'true', '120');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, isUnique, cooldown)
VALUES ('3', '92', 'Summons a drone at the target location for 6 seconds (X / 1.5X range). The drone reveals and disables all invisible traps and wards within an X / 1.5X-unit radius. (60 second cooldown).', 'true', 'true', '60');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, isUnique)
VALUES ('4', '2', 'Restores 4 mana when you kill an enemy unit.', 'false', 'false');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, isUnique)
VALUES ('5', '3', 'Basic Attacks restore 3 health for ranged, and 5 health for melee champions', 'false', 'false');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, isUnique)
VALUES ('6', '1', 'Blocks 8 damage from champion basic attacks.', 'false', 'true');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, consumesOnActive, isUnique)
VALUES ('7', '4', 'Restores 150 health over 15 seconds.', 'true', 'true', 'false');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, consumesOnActive, isUnique)
VALUES ('8', '5', 'Restores 100 mana over 15 seconds.', 'true', 'true', 'false');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, consumesOnActive, isUnique)
VALUES ('9', '6', 'Places an invisible ward with 1100 range. Lasts 3 minutes.', 'true', 'true', 'false');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, consumesOnActive, isUnique)
VALUES ('10', '7', 'Places a visible ward with 1100 Vision Sight and 1000 range Magical Sight (can see invisible units). Has infinite duration', 'true', 'true', 'false');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, isUnique, cooldown)
VALUES ('11', '12', 'LIFELINE: Upon taking magic damage that would reduce health below 30%, grants a shield that absorbs 250 magic damage for 5 seconds (90 second cooldown).', 'false', 'true', '90');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, isUnique)
VALUES ('12', '13', ' COLD STEEL: If you are hit by a basic attack, you slow the attackers attack speed by 15% for 1 seconds.', 'false', 'true');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, isUnique)
VALUES('13', '15', ' COLD STEEL: When hit by basic attacks, reduces the attackers attack speed by 15% and movement speed by 10% for 1 second.', 'false', 'true');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, consumesOnActive, isUnique,  cooldown)
VALUES('14', '15', 'Slows the movement speed of nearby enemy units by 35% for 2 (+ 0.5% armor) (+ 0.5% magic resistance) seconds. 60 second cooldown (500 Range).', 'true', 'false', 'true', '60');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, isUnique)
VALUES ('15',  '18', ' Rage: Basic attacks grant 20 movement speed for 2 seconds on hit. Minion, monster, and champion kills grant 60 movement speed for 2 seconds. The movement speed bonus is halved for ranged champions.', 'false', 'true');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, isUnique)
VALUES ('15',  '24', ' Rage: Basic attacks grant 20 movement speed for 2 seconds on hit. Minion, monster, and champion kills grant 60 movement speed for 2 seconds. The movement speed bonus is halved for ranged champions.', 'false', 'true');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, isUnique)
VALUES ('16', '20',  'SPELLBLADE: On cast, for 10 seconds, your next basic attack deals 100% base AD bonus physical damage. 2 second cooldown.', 'false', 'true');

INSERT INTO passives_actives(passiveID, itemID, description, isActive, isUnique)
VALUES ('17', '24',  'SPELLBLADE: On cast, for 10 seconds, your next basic attack deals 200% base AD bonus physical damage. 2 second cooldown.', 'false', 'true');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('8', '13', '2');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('9', '12', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('10', '12', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('13', '15', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('14', '15', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('16', '18', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('10', '18', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('19', '20', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('17', '20', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('21', '23', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('22', '23', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('23', '24', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('20', '24', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('18', '24', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('19', '25', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('19', '28', '2');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('28', '26', '1');

INSERT INTO itemPaths(buildsFrom, itemID, buildsFromCount)
VALUES ('25', '26', '1');


INSERT INTO schedule(matchID, matchDT, team1, team2, winner)
VALUES ('1', '2014-03-15 6:00:00', 'Counter-Logic Gaming', 'Cloud 9', 'Counter-Logic Gaming');

INSERT INTO schedule(matchID, matchDT, team1, team2, winner)
VALUES ('2', '2014-03-15 7:00:00', 'Team Dignitas', 'Team Solomid', 'Team Solomid');

INSERT INTO schedule(matchID, matchDT, team1, team2, winner)
VALUES ('3', '2014-03-16 6:00:00', 'Evil Geniuses', 'Team Coast', 'Evil Geniuses');

INSERT INTO team_stats (matchID, teamName, gameLength, towersTaken, dragonsTaken, baronsTaken)
VALUES ('1', 'Counter-Logic Gaming', '00:36:23', '8', '4', '1');

INSERT INTO team_stats (matchID, teamName, gameLength, towersTaken, dragonsTaken, baronsTaken)
VALUES ('1', 'Cloud 9', '00:36:23', '5', '1', '0');

INSERT INTO team_stats (matchID, teamName, gameLength, towersTaken, dragonsTaken, baronsTaken)
VALUES ('2', 'Team Dignitas', '00:26:59', '3', '1', '0');

INSERT INTO team_stats (matchID, teamName, gameLength, towersTaken, dragonsTaken, baronsTaken)
VALUES ('2', 'Team Solomid', '00:26:59', '9', '4', '2');

INSERT INTO team_stats (matchID, teamName, gameLength, towersTaken, dragonsTaken, baronsTaken)
VALUES ('3', 'Evil Geniuses',  '00:31:48', '9', '4', '1');

INSERT INTO team_stats (matchID, teamName, gameLength, towersTaken, dragonsTaken, baronsTaken)
VALUES ('3', 'Team Coast', '00:31:48', '5', '2', '0');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES( 'Cruzerthebruzer', '2', 'Renekton', '2', '3', '2', '189', '8523', '4', '2', '21', '5', '18', '24', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, trinket)
VALUES ('Crumbzz', '2', 'Vi', '1', '4', '4', '82', '6425', '4', '7', '15', '18', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, trinket)
VALUES ('Scarra', '2', 'Orianna', '3', '3', '4', '270', '10002', '4', '7', '2', '19', '23', '91');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Imaqtpie', '2', 'Caitlyn', '2', '5', '5', '295', '9852', '15', '4' , '7', '2', '28', '24', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, trinket)
VALUES ('Kiwikid', '2', 'Thresh', '0', '4', '8', '14', '6064', '4', '5', '9', '20', '92');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, trinket)
VALUES ('Xpecial', '2', 'Lulu', '1', '1', '11', '23', '8491', '4', '7', '9', '12', '19', '92');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Wildturtle', '2', 'Vayne', '8', '2', '4', '324', ' 12063', '8', '9', '10', '23', '12', '5', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('TheOddOne', '2', 'Elise', '4', '2', '12', ' 102', '9423', '4', '7', '2', '12', '15', '19', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Dyrus', '2', 'Volibear', '4', '3', '12', '298', '10423', '4', '7', '15', '14', '12', '21', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Bjergsen', '2', 'Ahri', '1', '0', '9', '301', '11206', '4', '7', '25', '23', '12', '17', '91');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, trinket)
VALUES ('Krepo', '3', 'Blitzcrank', '2', '1', '12', '31', '7234', '4', '7', '12', '14', '15', '92');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Yellowpete', '3', 'Lucian', '9', '1', '6', '342', '13023', '6', '4', '7', '21', '22', '24', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, trinket)
VALUES ('Snoopeh', '3', 'Shyvanna', '4', '2', '12', '127', '8412', '4', '7', '22', '21', '27', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Innox', '3', 'Dr. Mundo', '5', '2', '13', '320', '11985', '4', '7', '20', '21', '22', '23', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Pobelter', '3', 'Annie', '6', '3', '9', '301', '11245', '4', '7', '12', '14', '15', '23', '91');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ( 'Nintendudex', '3', 'Elise', '1', '4', '2', '78', '7009', '12', '5', '18', '7', '4', '25', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('ZionSpartan', '3', 'Volibear', '4', '3', '3', '279', '9142', '4', '12', '14', '15', '18', '20', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, trinket)
VALUES ('Daydreamin', '3', 'Thresh', '0', '5', '4', '9', '6032', '4', '7', '12', '13', '14', '92');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, trinket)
VALUES ('Shiphtur', '3', 'Orianna', '2', '6', '2', '231', '8932', '4', '7', '14', '21', '22', '91');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, trinket)
VALUES ('Wizfujiin', '3', 'Caitlyn', '2', '7', '4', '240', '9102', '4', '7', '5', '19', '23', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Doublelift', '1', 'Vayne', '10', '1', '7', '390', '14002', '4', '7', '19', '20', '21', '22', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Link', '1', 'Gragas', '3', '0', '12', '402', '13952', '4', '7', '22', '24', '28', '13', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Aphromoo', '1', 'Thresh', '0', '1', '17', '23', '9234', '4', '7', '19', '23', '20', '22', '92');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Nien', '1', 'Dr. Mundo', '2', '2', '12', '372', '12345', '4', '7', '28', '27', '25', '23', '91');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Dexter', '1', 'Volibear', '5', '1', '12', '90', '9923', '4', '7', '28', '18', '12', '16', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('LemonNation', '1', 'Annie', '1', '4', '3', '30', '6613', '4', '7', '12', '8', '3', '2', '92');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Sneaky', '1', 'Caitlyn', '2', '5', '3', '224','7024', '4', '7', '21', '22', '23', '18', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Hai', '1', 'Ahri', '2', '5', '2', '199', '7923', '4', '8', '2', '3', '22', '26', '90');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Meteoes', '1', 'Elise', '2', '5', '4', '68', '7201', '4', '7', '12', '14', '15', '16', '91');

INSERT INTO player_stats (IGN, matchID, champion, kills, deaths, assists, creepScore, goldEarned, item1, item2, item3, item4, item5, item6, trinket)
VALUES ('Balls', '1', 'Shyvanna', '3', '1', '4', '246', '8205', '4', '7', '14', '17', '19', '24', '90');

select * from schedule

------------------------views-----------------------------

CREATE OR REPLACE VIEW itemsWithPassivesActives AS
select distinct items.itemId, items.itemName, items.health, items.mana, items.armor, items.healthper5, items.manaper5,
items.cdr, items.mr, items.ad, items.ap, items.costGold, items.itemCountMax, items.isStackable, passives_actives.description
from items, passives_actives
where passives_actives.itemID = items.itemid;

CREATE OR REPLACE VIEW itemsMadeFromRecipe AS

select items.itemId, items.itemName, items.health, items.mana, items.armor, items.healthper5, items.manaper5,
items.cdr, items.mr, items.ad, items.ap, items.costGold, items.itemCountMax, items.isStackable, itemPaths.buildsFrom, itempaths.buildsFromCount
from items, itempaths
where items.itemID = itempaths.itemID



-----------------------stored procedures----------------------

CREATE OR REPLACE FUNCTION PlayerStatsWithChampion(text, REFCURSOR) returns refcursor as
$$
declare name text 		:=$1;
	resultset REFCURSOR 	:=$2;
begin
	open resultset for
	select ign, kills, deaths, assists, creepscore, goldearned
	from player_stats
	where $1 = player_stats.champion;
	return resultset;
end;
$$
language plpgsql;

select playerstatswithchampion('Volibear', 'results');
Fetch all from results;

CREATE OR REPLACE FUNCTION CheckWinsForTeam(text, REFCURSOR) returns refcursor as
$$
declare teamName text		:=$1;
	resultset REFCURSOR	:=$2;
begin
	open resultset for
	select COUNT(winner) as Wins
	from schedule
	where winner = $1;
	return resultset;
end;
$$
language plpgsql;

select checkwinsforteam('Evil Geniuses', 'results');
Fetch all from results;

CREATE OR REPLACE FUNCTION PlayersThatPlayPosition(text, REFCURSOR) returns refcursor as
$$
declare position text		:=$1;
	resultset REFCURSOR	:=$2;
begin
	open resultset for
	select ign, teamname, fname, lname, dob, contract_end, playerbackground
	from players
	where players.position = $1;
	return resultset;
end;
$$
language plpgsql;

select PlayersThatPlayPosition('Top Lane', 'results');
Fetch all from results;



--------------------------------------Reports---------------------------------

select champion, count(champion)
from player_stats
group by champion
order by count desc

select distinct players.fName, players.lname
from players, player_stats, items, passives_actives
where players.ign = player_stats.ign and
	player_stats.item1 = items.itemID or
	player_stats.item2 = items.itemID or
	player_stats.item3 = items.itemID or
	player_stats.item4 = items.itemID or
	player_stats.item5 = items.itemID or
	player_stats.item6 = items.itemID and
	items.itemID = passives_actives.itemID and
	passives_actives.consumesonactive = true
	
--------------------------------------security---------------------------------------

CREATE USER LCSadmin WITH PASSWORD 'admin';

REVOKE ALL on teams from LCSadmin;
REVOKE ALL on players from LCSadmin;
REVOKE ALL on items from LCSadmin;
REVOKE ALL on schedule from LCSadmin;
REVOKE ALL on team_stats from LCSadmin;
REVOKE ALL on champions from LCSadmin;
REVOKE ALL on player_stats from LCSadmin;
REVOKE ALL on passives_actives from LCSadmin;
REVOKE ALL on itemPaths from LCSadmin;

GRANT insert, update, delete, select on players to LCSadmin;
GRANT insert, update, delete, select on teams to LCSadmin;
GRANT insert, update, delete, select on items to LCSadmin;
GRANT insert, update, delete, select on schedule to LCSadmin;
GRANT insert, update, delete, select on team_stats to LCSadmin;
GRANT insert, update, delete, select on champions to LCSadmin;
GRANT insert, update, delete, select on player_stats to LCSadmin;
GRANT insert, update, delete, select on passives_actives to LCSadmin;
GRANT insert, update, delete, select on itemPaths to LCSadmin;

CREATE USER genericUser;
REVOKE ALL on teams from genericUser;
REVOKE ALL on players from genericUser;
REVOKE ALL on items from genericUser;
REVOKE ALL on schedule from genericUser;
REVOKE ALL on team_stats from genericUser;
REVOKE ALL on champions from genericUser;
REVOKE ALL on player_stats from genericUser;
REVOKE ALL on passives_actives from genericUser;
REVOKE ALL on itemPaths from genericUser;

GRANT select on players to genericUser;
GRANT select on teams to genericUser;
GRANT select on items to genericUser;
GRANT select on schedule to genericUser;
GRANT select on team_stats to genericUser;
GRANT select on champions to genericUser;
GRANT select on player_stats to genericUser;
GRANT select on passives_actives to genericUser;
GRANT select on itemPaths to genericUser;