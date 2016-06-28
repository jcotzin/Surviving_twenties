cats = Array.new(100, 1)
length = cats.length;
#puts length

length.times {|i|
	
	length.times {|j|
		if ((i+1)*(j+1) <= 100) then
			l = (i+1)*(j+1)
			l = l - 1;
			if(cats[l] == 1) then cats[l] = 0 
			elsif(cats[l] == 0) then cats[l] = 1 end
		else

		end
	}
	
	puts "Go number #{i+1}"
	puts cats
}
