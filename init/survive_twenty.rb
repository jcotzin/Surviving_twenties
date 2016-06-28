user = {:name => "", :age => 0, :gender => "", :ori => "", :points => 0, :turns => 1, :cash => 0, :assets => 0.0, :revenue => 0.0, :bills => 0.0, :liab => 0.0, :stocks => {}, :bonds => {}, :RE => {}, :spouse =>{}, :children=> {}, :job=>{have: 0, name: ""},:mood => 0, :sick => [0,0,0,0,0,0]}
turn = {:mon => "Jan", :old => 0, :pay => []}
hold = 0

def getName(user)
	puts "First what is your name?"
	n = gets.chomp;
	user[:name] = n.to_s
	puts "\n"
end

def getAge(user, turn)
	puts "Next, how old are you? This will determine how long the game will be. Must be between 20 and 30."
	age = gets.chomp.to_i
	if (age >= 20 && age < 30) then
		user[:age] = age
		turn[:old] = age
	else 
		puts "Not an applicable age, please try again."
		getAge(user, turn)
	end
	puts "\n"
end

def getGender(user)
	puts "What is your gender? Please enter M for male, and F for female."
	gender = gets.chomp
	case gender
	when "M", "Male", "m", "male" 
		user[:gender] = gender.capitalize
	when "F", "Female", "f", "female"
		user[:gender] = gender.capitalize
	else 
		puts "Not an applicable gender, please try again."
		getGender(user)
	end
	puts "\n"
end

def getOri(user)
	puts "What is your sexual orientation? Hetero? or Homo?"
	ori = gets.chomp
	case ori
	when "Hetero" , "hetero"
		user[:ori] = ori.capitalize
	when "Homo" , "homo"
		user[:ori] = ori.capitalize
	else
		puts "Not an applicable orientation, please try again."
		getOri(user)
	end
	puts "\n"
end

def beginGame(user, turn, hold)
	if (user[:age] >=20 && user[:age] <= 25) then
		puts "You woke up one day and finally realized that you have wasted all this time after college. You finally get up the Gaul to put on some pants and leave your house before noon. Type \"Play\" to begin your adult life."
		puts "\n"
		puts "\n"
		play(user, turn, hold)

	elsif (user[:age] <= 30 || user[:age] > 26) then
		puts "After working three different uber jobs that didn't even afford your student loan debts. You come to the understanding that it's time to get your stuff together."
		puts "\n"
		puts "\n"
		play(user, turn, hold)

	elsif (user[:age] <= 19 || user[:age] > 30) then
		puts "There is an error, logging error information now..."
		puts "\n"
	end
end

def play(user, turn, hold)
	puts "Type 'play' to start the next turn. Type 'exit' to leave game."
	play = gets.chomp
	case play
	when "play", "p"
		puts "\n"
		makeLine
		master_roll(user, turn, hold)
	when "exit", "e"
		#break
		#break
		#break
	else
		puts "Didn't type properly please try again?"
		makeLine
		play(user, turn, hold)
	end
end

def master_roll(user, turn, hold)
	
	puts "Turn Number #{user[:turns]}                                Month: #{turn[:mon]}    Age:  #{user[:age]}"
	puts "\n"
	puts "\n"

	rll = roll(90)
	if (rll > 0 && rll <= 5) then
		
		r = roll(6)
		hold = r
		puts "\n You are hurt! You have "
		findSick(user, hold)
		print "Your costs are "
		deducCash(user, hold, turn, returnPay(rll, r), returnPayment(rll, r))
		print job(user)
		puts "\n"

		
		updateTurn(user, turn)
		updateMood(hold, user)

		updateStatus(user, turn, hold)
		play(user, turn, hold)

	elsif (rll > 5 && rll <= 12) then
		
		r = roll(6)
		hold = r
		puts " \n You got into a car accident, "
		brokenBones(hold)
		print " You costs are "
		deducCash(user, hold, turn, returnPay(rll, r), returnPayment(rll, r))
		if(roll(6) > 3)then
			print job(user)
		else
			print " Don't worry your job status wasn't affected."
		end

		updateTurn(user, turn)
		updateMood(hold, user)

		updateStatus(user, turn, hold)
		play(user, turn, hold)

	elsif (rll > 12  && rll <= 20) then
		
		r = roll(6)
		hold = r
		if(user[:job][:have] == 0) then
			
			puts "You woke up and realized that, YOU STILL DON'T HAVE A JOB. So your now depressed."
			
			updateTurn(user, turn)
			updateMood(hold, user)

			updateStatus(user, turn, hold)
			play(user, turn, hold)

		elsif(user[:job][:have] >= 1) then
			
			puts "Sorry boss, you lost your job."
			user[:job][:have] = 0
			user[:job][:name] = ""
			user[:revenue] = 0
			
			updateTurn(user, turn)
			updateMood(hold, user)

			updateStatus(user, turn, hold)
			play(user, turn, hold)

		end

	elsif (rll > 20 && rll <=35)
		
		r = roll(3)
		hold = r

		case r 
		when 1
			puts "You got angry at an old, blind lady. But it was a foolish decision, because she specializes in blind kung fu. The police laugh and haul you off to jail. You had to pay $200 to post bail."	
			user[:cash] = user[:cash] - 200
		when 2
			puts "You got cut off for a parking spot...and you don't play that shit. It started out as a simple argument, but nothing that simple stays that simple. You were hauled off to jail. You had to pay $400 to post bail."
			user[:cash] = user[:cash] - 400
		when 3
			if(user[:ori] == "Hetero" && user[:gender] == "M") then
				puts "You got into a bar fight over a big butt and a smile (told you they poison). You were hauled off to jail. You had to pay $1000 to post bail."
			elsif (user[:ori] == "Hetero" && user[:gender] == "F") then
				puts "It started out just talking. A little meet-cute over a bottle of wine. But the other lady carrying around his two other children didn't fell such. You wanted to talk it out, but she pulled your hair...that shit is expensive! You were hauled off to jail. You had to pay $1000 to post bail"
			elsif (user[:ori] == "Homo" && user[:gender] == "M") then
				puts "It's your turn for the lime light, but the contestant behind you wants to channel their inner Whitney Houston and belt out 'I WILL ALWAYS LOVE YOU!!!' Well your fist is saying they need to wait their turn. Your fist makes contact, and there is alot of blood. You were hauled off to jail. You had to pay $1000 to post bail."
			elsif (user[:ori] == "Homo" && user[:gender] == "F") then
				puts "You wanted just to leave, so you packed up the UHAUL. But the 'love of your life' believes she has too much claim on your belongings. She slashes the tires. You slash her face. You were hauled off to jail. You had to pay $1000 to post bail"
			end
			user[:cash] = user[:cash] - 1000
		end

		updateTurn(user, turn)
		updateMood(hold, user)

		updateStatus(user, turn, hold)
		play(user, turn, hold)

	elsif (rll > 35 && rll <= 48) then

		r = roll(3)
		case r
		when 1
			puts "They were up by 2 touchdowns, with only 2 minutes to go. How...the...hell! Probably shouldn't of bet. You lost 10 dollars."
			user[:cash] = user[:cash] - 10
		when 2
			puts "It seemed simple...Nipples, Clamps, hold for 10 secs. When you came to they said you didn't even last 3. You lost 25 dollars on the bet."
			user[:cash] = user[:cash] - 25
		when 3
			puts "You use to do it all the time with a pencil, so why not a knife. But the 'Five-Finger Fillet with a knife is MUCH HARDER WITH A KNIFE. You were suppose to lose $50 to your friend, but they used that $50 to fix your hand."
			user[:cash] = user[:cash] - 50
		end

		hold = 1
		updateTurn(user, turn)
		updateMood(hold, user)

		updateStatus(user, turn, hold)
		play(user, turn, hold)

	elsif (rll > 48 && rll <= 55) then
		
		puts "You found a dollar...You found a dollar...You found a dollar Hey,hey,hey, HEY!"
		user[:cash] =  user[:cash] + 1

		updateTurn(user, turn)
		user[:mood] = user[:mood] + 1

		updateStatus(user, turn, hold)
		play(user, turn, hold)


	elsif (rll > 55 && rll <= 70) then
		 r = roll(4)
		 case r
		 when 1
		 	puts "You found 5 bucks in the pair of jeans you finally decided to wash."
		 	user[:cash] = user[:cash] + 5
		 when 2
		 	puts "You got 10 bucks buy selling your stoned friend a 'dime bag' of oregano."
		 	user[:cash] = user[:cash] + 10
		 when 3
		 	puts "Your grandmother mistakenly thought it was your birthday so she gave you 20 dollars. Yeah it's your grandma...but it's 20 dollars."
		 	user[:cash] = user[:cash] + 20
		 when 4
		 	if(user[:ori] == "Hetero" && user[:gender] == "M") then
				puts "A wonderful cougar gave you 50 bucks and her room key. You left the room key...but took the 50."
			elsif (user[:ori] == "Hetero" && user[:gender] == "F") then
				puts "A dirty old man thought you were a stripper and 'tipped' you a 50. Regardless of the offense, that's still a come up."
			elsif (user[:ori] == "Homo" && user[:gender] == "M") then
				puts "A dirty old man thought you were a stripper and 'tipped' you a 50. Regardless of the offense, that's still a come up."
			elsif (user[:ori] == "Homo" && user[:gender] == "F") then
				puts "A wonderful cougar gave you 50 bucks and her room key. You left the room key...but took the 50."
			end
			user[:cash] = user[:cash] + 50
			
		end


		updateTurn(user, turn)
		user[:mood] = user[:mood] + 5

		updateStatus(user, turn, hold)
		play(user, turn, hold)

	elsif (rll > 70 && rll <= 80) then
		
		r = roll(4)
		case r
		when 1
			puts "You started eating Kale. Now you believe you will live for 100 years. Your mood has increased by 5 points. Even though everyone around might get tired of you."
			user[:mood] = user[:mood] + 5
		when 2
			puts "You started soul cycle and now a marathon seems like nothing for you. Your mood increased by 10 points."
			user[:mood] = user[:mood] + 10
		when 3
			puts "You met a new on-again/off again 'friend-with-benefits'. The only thing they are good for is a mood boost. Your mood increased by 12 points."
			user[:mood] = user[:mood] + 12
		when 4
			puts "You found the limitless pill. You can now do ANYTHING!!...or at least you think. Mood increased by 20 points."
			user[:mood] = user[:mood] + 20
		end 

		updateTurn(user, turn)
		user[:mood] = user[:mood] + 5

		updateStatus(user, turn, hold)
		play(user, turn, hold)

	elsif (rll > 80 && rll <= 90) then
		r = roll(12)
		acquireJob(r, user)

		updateTurn(user, turn)
		user[:mood] = user[:mood] + 40

		updateStatus(user, turn, hold)
		play(user, turn, hold)

	elsif (rll > 90 && rll <= 100) then

	else

	end
end

def roll(t)
	rll = (rand(t)).round
	if (rll == 0)then
		roll(t)
	else
		return rll
	end
end

def updateTurn(user, turn)
	user[:turns] = user[:turns] + 1
	if (user[:age] > 29 ) then
		finishGame(user, turn)
	elsif (user[:age] <= 29 && user[:age] >= 20) then
		changeMonth(user, turn)
	else 
		puts "There was an error. Logging error information right now..."
	end
end

def changeMonth(user, turn)
	case turn[:mon]
	when "Jan"
		turn[:mon] = "Feb"
	when "Feb"
		turn[:mon] = "Mar"
	when "Mar"
		turn[:mon] = "Apr"
	when "Apr"
		turn[:mon] = "May"
	when "May"
		turn[:mon] = "Jun"
	when "Jun"
		turn[:mon] = "Jul"
	when "Jul"
		turn[:mon] = "Aug"
	when "Aug"
		turn[:mon] = "Sep"
	when "Sep"
		turn[:mon] = "Oct"
	when "Oct"
		turn[:mon] = "Nov"
	when "Nov"
		turn[:mon] = "Dec"
	when "Dec"
		turn[:mon] = "Jan"
		user[:age] = user[:age] + 1
		finishGame(user, turn)
	end
end

def finishGame(user, turn)
	if(user[:age] > 29)then
		puts "The game is over. Calculating points..."
		puts "Your score is #{user[:points]}"
		exit;
	else

	end
end

def findSick(user, hold)
	
	case hold
	when 1
		if(user[:sick][0] == 1) then
			print " a STD, but you already had it."
		elsif(user[:sick][0] == 0) then
			print " a STD, "
			user[:sick][0] = 1
		end
	when 2
		if(user[:sick][1] ==1) then
			print " lupus, but you already had it."
		elsif(user[:sick][1] == 0) then
			print " lupus, "
			user[:sick][1] = 1
		end

	when 3
		if(user[:sick][2] == 1)then
			print " Type 1 Diabetes, but you already had it."
		elsif(user[:sick][2] == 0) then
			print " Type 1 Diabetes, "
			user[:sick][2] = 1
		end

	when 4
		if(user[:sick][3] == 1)then
			print " a very bad infection, but you already had it."
		elsif(user[:sick][3] == 0) then
			print " a very bad infection, "
			user[:sick][3] = 1
		end

	when 5
		if(user[:sick][4] == 1)then
			print " irritable bowl syndrome, but you already had it."
		elsif (user[:sick][4] == 0)then
			print " irritable bowl syndrome, "
			user[:sick][4] = 1
		end
			

	when 6
		if(user[:sick][5] == 1)then
			print " a tiny cut, but your a baby, but you already had it."
		elsif (user[:sick][5] == 0) then
			print " a tiny cut, but your a baby, "
			user[:sick][5] = 1
		end
			

	end
end

def returnPay(rll, r)
	if(rll >= 0 && rll <= 5)then
		case r
		when 1
			return 10000
		when 2 
			return 7800
		when 3
			return 5900
		when 4
			return 3600
		when 5
			return 1000
		when 6 
			return 120
		end
	elsif(rll > 5 && rll <= 12)then
		case r
		when 1
			return 1100
		when 2
			return 1900
		when 3
			return 2500
		when 4
			return 3200
		when 5
			return 3800
		when 6
			return 5400
		end
	else

	end
end

def returnPayment(rll, r)
	if(rll >= 0 && rll <= 5)then
		case r
		when 1
			return 350
		when 2 
			return 270
		when 3
			return 208
		when 4
			return 154
		when 5
			return 85
		when 6 
			return 8
		end
	elsif(rll > 5 && rll <= 12)then
		case r
		when 1
			return 41
		when 2
			return 70
		when 3
			return 92
		when 4
			return 118
		when 5
			return 140
		when 6
			return 200
		end
	else

	end
end

def deducCash(user, hold, turn, pay, payment)

	if(user[:cash] <= 0) then

		user[:bills] = user[:bills] + payment
		p = ((pay.to_i*1.1)/payment.to_i).to_int
		turn[:pay].push(Array.new(pay, p))
		print "payments of $#{payment}."

	elsif (user[:cash] > 0) then
		print "$#{pay}."
		if (user[:cash] < pay) then
			user[:bills] = user[:bills] + payment
			p = ((pay.to_i*1.1)/payment.to_i).to_int
			turn[:pay].push(Array.new(pay, p) )
			print " You can't afford to pay straight out. You set up a payment plan for $#{payment}."
		else 
			print " Would you like to pay straight out or set up a payment Plan?"
			puts " Press 1 to pay straight out. Press 2 to setup payment plan."

			choosePay(pay, payment, user, turn)	
		end
	end
end

def choosePay(pay, payment, user, turn)
	
	a = gets.chomp
	case a
	when 1 , "1"
		user[:cash] = user[:cash] - pay
	when 2 , "2"
		user[:bills] = user[:bills] + payment
		p = ((pay.to_i*1.1)/payment.to_i)
		# turn[:pay].push(Array.new({:a => payment, :b => p.to_i}))
	else 
		puts "Sorry, didn't understand your answer."
		a = nil
		choosePay(pay, payment, user)
	end
end

def acquireJob(r, user)
	case r
	when 1 
		puts "YOU FOUND A JOB. You were hired as a McDonald's cashier. Enjoy your minimum wage."
		puts "Do you want to keep this job? Press 1. Press 2 if you want to pass it up."
		j = gets.chomp
		case j
		when "1"
			user[:job][:have] = 1
			user[:job]["name"] = "McDonald's cashier"
			user[:revenue] = user[:revenue] + 1200;
		when "2"

		else 
			puts "Didn't not understand your answer. Please try again."
			acquireJob(r, user)
		end
	when 2
		puts "YOU FOUND A JOB. You were hired as a room service attendant. Maybe they will leave the safe open and you come up a little."
		puts "Do you want to keep this job? Press 1. Press 2 if you want to pass it up."
		j = gets.chomp
		case j
		when "1"
			user[:job][:have] = 1
			user[:job]["name"] = "Room Service Attendant"
			user[:revenue] = user[:revenue] + 1600;
		when "2"

		else 
			puts "Didn't not understand your answer. Please try again."
			acquireJob(r, user)
		end
	when 3
		puts "YOU FOUND A JOB. You were hired as a bartender. Enjoy catering after people you got wasted. Hopefully they're not so intoxicated that they forget to tip."
		puts "Do you want to keep this job? Press 1. Press 2 if you want to pass it up."
		j = gets.chomp
		case j
		when "1"
			user[:job][:have] = 1
			user[:job]["name"] = "Bartender"
			user[:revenue] = user[:revenue] + 2080;
		when "2"

		else 
			puts "Didn't not understand your answer. Please try again."
			acquireJob(r, user)
		end
	when 4
		puts "YOU FOUND A JOB. You were hired as a Hair Stylist. Clearly, they were desperate because you don't really have steady hands."
		puts "Do you want to keep this job? Press 1. Press 2 if you want to pass it up."
		j = gets.chomp
		case j
		when "1"
			user[:job][:have] = 1
			user[:job]["name"] = "Hair Stylist"
			user[:revenue] = user[:revenue] + 2880;
		when "2"

		else 
			puts "Didn't not understand your answer. Please try again."
			acquireJob(r, user)
		end
	when 5
		puts "YOU FOUND A JOB. You were hired as Elementary School Teacher. Whatever you do... don't mess up the children."
		puts "Do you want to keep this job? Press 1. Press 2 if you want to pass it up."
		j = gets.chomp
		case j
		when "1"
			user[:job][:have] = 1
			user[:job]["name"] = "Elementary School Teacher"
			user[:revenue] = user[:revenue] + 3100;
		when "2"

		else 
			puts "Didn't not understand your answer. Please try again."
			acquireJob(r, user)
		end
	when 6
		puts "YOU FOUND A JOB. You were hired as a IT Professional. Don't worry you can always just pretend like you know what your doing, because nobody else does either."
		puts "Do you want to keep this job? Press 1. Press 2 if you want to pass it up."
		j = gets.chomp
		case j
		when "1"
			user[:job][:have] = 1
			user[:job]["name"] = "IT Professional"
			user[:revenue] = user[:revenue] + 4160;
		when "2"

		else 
			puts "Didn't not understand your answer. Please try again."
			acquireJob(r, user)
		end
	when 7
		puts "YOU FOUND A JOB. You were hired as a Bank Manager. For Real? I can't believe they trusted you with money."
		puts "Do you want to keep this job? Press 1. Press 2 if you want to pass it up."
		j = gets.chomp
		case j
		when "1"
			user[:job][:have] = 1
			user[:job]["name"] = "Bank Manager"
			user[:revenue] = user[:revenue] + 6200;
		when "2"

		else 
			puts "Didn't not understand your answer. Please try again."
			acquireJob(r, user)
		end
	when 8
		puts "YOU FOUND A JOB. You were hired as a Chemical Engineer. Remember, YOU ARE NOT HEISENBURG."
		puts "Do you want to keep this job? Press 1. Press 2 if you want to pass it up."
		j = gets.chomp
		case j
		when "1"
			user[:job][:have] = 1
			user[:job]["name"] = "Chemical Engineer"
			user[:revenue] = user[:revenue] + 8320;
		when "2"

		else 
			puts "Didn't not understand your answer. Please try again."
			acquireJob(r, user)
		end
	when 9
		puts "YOU FOUND A JOB. You were hired as a Hedge Fund Analyst. So as long as you do exactly what they say, when they say it, and do it with a smile, you will be on your way to being a millionaire."
		puts "Do you want to keep this job? Press 1. Press 2 if you want to pass it up."
		j = gets.chomp
		case j
		when "1"
			user[:job][:have] = 1
			user[:job]["name"] = "Hedge Fund Analyst"
			user[:revenue] = user[:revenue] + 10500;
		when "2"

		else 
			puts "Didn't not understand your answer. Please try again."
			acquireJob(r, user)
		end
	when 10
		puts "YOU FOUND A JOB. You were hired as a Lawyer. Fingers crossed you don't have to defend a pedophile."
		puts "Do you want to keep this job? Press 1. Press 2 if you want to pass it up."
		j = gets.chomp
		case j
		when "1"
			user[:job][:have] = 1
			user[:job]["name"] = "Lawyer"
			user[:revenue] = user[:revenue] + 13000;
		when "2"

		else 
			puts "Didn't not understand your answer. Please try again."
			acquireJob(r, user)
		end
	when 11
		puts "YOU FOUND A JOB. You were hired as a Doctor. Whatever you do, don't lose your stethoscope inside of a body"
		puts "Do you want to keep this job? Press 1. Press 2 if you want to pass it up."
		j = gets.chomp
		case j
		when "1"
			user[:job][:have] = 1
			user[:job]["name"] = "Doctor"
			user[:revenue] = user[:revenue] + 14200;
		when "2"

		else 
			puts "Didn't not understand your answer. Please try again."
			acquireJob(r, user)
		end
	when 12
		puts "YOU FOUND A JOB. You were hired as a CEO. Cuz, you know, young CEO's always ends up being the best choice."
		puts "Do you want to keep this job? Press 1. Press 2 if you want to pass it up."
		j = gets.chomp
		case j
		when "1"
			user[:job][:have] = 1
			user[:job]["name"] = "CEO"
			user[:revenue] = user[:revenue] + 20000;
		when "2"

		else 
			puts "Didn't not understand your answer. Please try again."
			acquireJob(r, user)
		end
	else 
		puts "There was an error. Logging error information..."
	end
end

def returnRev(user)
	
	job = user[:job]["name"]
	case job
	when "McDonald's cashier"
		return 1200
	when "Room Service Attendant"
		return 1600
	when "Bartender"
		return 2080
	when "Hair Stylist"
		return 2880
	when "Elementary School Teacher"
		return 3100
	when "IT Professional"
		return 4160
	when "Bank Manager"
		return 6200
	when "Chemical Engineer"
		return 8320
	when "Hedge Fund Analyst"
		return 10500
	when  "Lawyer"
		return 13000
	when "Doctor"
		return 14200
	when "CEO"
		return 20000
	else 
		puts "There was an error. Logging error information..."
	end
end

def updateMood(hold, user)
	
	case hold
	when 1
		user[:mood] = user[:mood] - 5
	when 2
		user[:mood] = user[:mood] - 10
	when 3
		user[:mood] = user[:mood] - 15
	when 4
		user[:mood] = user[:mood] - 20
	when 5
		user[:mood] = user[:mood] - 25
	when 6
		user[:mood] = user[:mood] - 30
	end
end

def job(user)
	if(user[:job][:have] == 0)then
		puts " You didn't lose your job....because you didn't have any."
	elsif (user[:job][:have] == 1) then
		x = roll(6)
		case x
		when 1,2,3
			puts " You didn't lose your job though. I guess that's good."
		when 4,5,6
			puts " You lost your job. Sorry slick."
			user[:revenue] = user[:revenue] - returnRev(user)
			user[:job][:have] = 0
			user[:job]["name"] = ""
		end
	else
		puts "An error occurred. Logging error info now..."
	end
end

def brokenBones(hold)

	case hold
	when 1
		print " and you broke one bone. "
	when 2
		print " and you broke two bones. "
	when 3
		print " and you broke three bones. "
	when 4
		print " and you broke four bones. "
	when 5
		print " and you broke five bones. "
	when 6
		print " and you broke six bones. "
	end
end	

def makePay(user, turn)
	rev = user[:revenue]
	liab = user[:liab]
	bill = user[:bills]
	c = user[:cash]

	c = c + rev
	c = c - bill

	user[:cash] = c
end

def calcPoints(user, turn)
	
	turn = user[:turns].to_i
	cash = user[:cash].to_i
	ass = user[:assets].to_i
	rev = user[:revenue].to_i
	bill = user[:bills].to_i
	mood = user[:mood].to_i

	score = ((((cash+(ass*2)+(rev * 0.5)) - ((bill -rev)*5))*(1000/(1000-mood)))/turn).to_int
	user[:points] = score 
end

def whatToDo(user, turn, hold)
	puts "You have this much $#{sprintf('%.2f',user[:cash])} on hand."
	puts "You have this many #{user[:points]} points"
	if(user[:bills] > user[:revenue]) then
		puts "And your bills are piling up! Better find some more money!"
	else

	end
	if(user[:mood] < 0) then
		puts "You are also severly depressed..."
	elsif(user[:mood] < 50 && user[:mood] >= 0) then
		puts "And your looking down in the dumps too."
	else
		puts "But your feeling good, they say that's the secret."
	end
end

def updateStatus(user, turn, hold)
	
	puts "\n"
	puts "\n"
	puts "\n"
	makePay(user, turn)
	calcPoints(user, turn)
	whatToDo(user, turn, hold)
	puts "\n"
	if(user[:job][:have] == 1)then
		puts "You are currently employed as a #{user[:job]["name"]}."
	else
		puts "You are currently not employed...Sorry!"
	end
	puts "\n"
	puts "\n"

end

def makeLine
	puts "\n"
	puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	puts "\n"
end

def init(user, turn, hold)
	
	puts "Welcome to surviving your twenties. The game where you play the economically hardest part of your life...over and over again! Try hard not to cry or develop a serious mental disorder."

	makeLine
	getName(user)
	makeLine
	getAge(user, turn)
	makeLine
	getGender(user)
	makeLine
	getOri(user)
	makeLine
	beginGame(user, turn, hold)
end

init(user, turn, hold)