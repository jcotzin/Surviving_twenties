class Person
	attr_accessor :hair_color
	attr_accessor :name

	def initialize(hair_color, name)
		@hair_color = hair_color
		@name = name
		# sing
	end

	def sing
		puts "I like big butts and I can not lie."	
	end
end

class Wyncoder < Person
	def code
		return "I am coding!"
	end
	def to_s
		return "This is the test string."
	end
	def inspect
		return "This is another test string."
	end
end

sandy = Person.new "brown hair", "Sandy"
walter = Wyncoder.new "blonde hair" , "Walter"

p walter
puts walter
# walter.to_s
# walter.code
# sandy.code


