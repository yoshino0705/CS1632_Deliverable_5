class CitySim
	attr_accessor :rng, :start, :locations, :books, :classes, :toy, :id, :current_place
	def initialize(id, rng = Random.new)
		# constructor

		@locations = ['Hospital', 'Cathedral', 'Hillman', 'Museum']
		@rng = rng
		@start = @locations.sample(random: Random.new(@rng.rand(100)))
		@books = 0
		@classes = 1
		@toy = 0
		@id = id
		@current_place = @start

	end

	def via(from, to)
		# returns the 'via' part of the message bvased on the 'from' location and the 'to' location

		if from == 'Museum' and to == 'Hillman'
			return 'Fifth Ave'
		elsif from == 'Hospital' and to == 'Hillman'
			return 'Foo St'
		elsif from == 'Museum' and to == 'Cathedral'
			return 'Bar St'
		elsif from == 'Hospital' and to == 'Cathedral'
			return 'Fourth Ave'
		elsif to == 'Hospital'
			return 'Foo St'
		elsif to == 'Museum'
			return 'Bar St'
		elsif to == 'Monroeville'
			return 'Fourth Ave'
		else
			return 'Fifth Ave'
		end			

	end

	def get_next()
		# create a table for the physical map
		# loc[from] = to
		loc = Hash.new
		loc['Hospital'] = ['Cathedral', 'Hillman'].sample(random: Random.new(@rng.rand(50)))
		loc['Cathedral'] = ['Monroeville', 'Museum'].sample(random: Random.new(@rng.rand(64)))
		loc['Hillman'] = ['Downtown', 'Hospital'].sample(random: Random.new(@rng.rand(87)))
		loc['Museum'] = ['Cathedral', 'Hillman'].sample(random: Random.new(@rng.rand(666)))

		# get the next location
		next_loc = loc[@current_place]

		# print the direction message
		puts "Driver #{@id} heading from #{@current_place} to #{next_loc} via #{via(@current_place, next_loc)}."

		return next_loc
	end

	def update_values(next_loc)
		# increment variables
		if next_loc == 'Hillman'
			@books += 1
		end

		if next_loc == 'Museum'
			@toy += 1
		end

		if next_loc == 'Cathedral'
			@classes *= 2
		end

		# assign the next location to the current_place variable
		if next_loc == 'Monroeville' or next_loc == 'Downtown'
			@current_place = 'Outside'				
		else
			@current_place = next_loc
		end

	end

	def results
		# prints the values of books, toy, and classes
		if @books == 1
			puts "Driver #{@id} obtained #{@books} book!"
		else
			puts "Driver #{@id} obtained #{@books} books!"
		end

		if @toy == 1
			puts "Driver #{@id} obtained #{@toy} dinosaur toy!"
		else
			puts "Driver #{@id} obtained #{@toy} dinosaur toys!"
		end

		if @classes == 1
			puts "Driver #{@id} attended #{@classes} class!"
		else
			puts "Driver #{@id} attended #{@classes} classes!"
		end

	end

end