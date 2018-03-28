require 'minitest/autorun'

require_relative 'CitySim'

class CitySimTest < Minitest::Test

	# a simple setup for creating an instance of CitySim
	# uses double and stub
	def setup
		rng = Minitest::Mock.new("test_rng")

		# a stub for random number
		def rng.rand; 1; end

		@driver = CitySim.new 0
	end

	# tests the newly created instance is not nil
	def test_new_driver_not_nil
		refute_nil @driver
	end

	# tests the newly created instance is part of CitySim class
	def test_new_driver_is_citysim_class
		assert_kind_of CitySim, @driver
	end

	# tests the class variables are same as default
	# where
	# books = 0
	# toy = 0
	# classes = 1
	def test_books_default_value
		assert_equal @driver.books, 0
	end

	def test_toy_default_value
		assert_equal @driver.toy, 0
	end

	def test_classes_default_value
		assert_equal @driver.classes, 1
	end

	# tests the other class variables aren't nil
	# which includes: locations, start, id, rng, current_place
	def test_locations_not_nil
		refute_nil @driver.locations
	end

	def test_start_not_nil
		refute_nil @driver.start
	end

	def test_id_not_nil
		refute_nil @driver.id
	end

	def test_rng_not_nil
		refute_nil @driver.rng
	end

	def test_current_place_not_nil
		refute_nil @driver.current_place
	end

	# UNIT TESTS FOR METHOD via(from, to)
	# Equivalence classes: 
	# 	from = 'Hospital', 'Cathedral', 'Hillman', 'Museum'
	# 	to = 'Hospital', 'Cathedral', 'Hillman', 'Museum', 'Monroeville'
	#   -> returns either 'Fourth Ave', 'Fifth Ave', 'Foo st', or 'Bar st'
	#   
	#   Unknown combinations of 'for' and 'to' or unknown input values for either 'from' and 'to'
	#   -> returns 'Fifth Ave'

	# KNOWN CASES:
	def test_via_Museum_Hillman
		assert_equal 'Fifth Ave', @driver.via('Museum','Hillman')
	end

	def test_via_Hospital_Hillman
		assert_equal 'Foo St', @driver.via('Hospital','Hillman')
	end

	def test_via_Museum_Cathedral
		assert_equal 'Bar St', @driver.via('Museum','Cathedral')
	end

	def test_via_Hospital_Cathedral
		assert_equal 'Fourth Ave', @driver.via('Hospital','Cathedral')
	end

	def test_via_Museum_Hospital
		assert_equal 'Foo St', @driver.via('Museum','Hospital')
	end

	def test_via_Cathedral_Hillman
		assert_equal 'Bar St', @driver.via('Cathedral','Museum')
	end

	def test_via_Museum_Monroeville
		assert_equal 'Fourth Ave', @driver.via('Museum','Monroeville')
	end


	# UNKNOWN CASES:

	# Tests when from = '', to = ''
	# EDGE CASE
	def test_via_empty_string
		assert_equal 'Fifth Ave', @driver.via('','')
	end

	# Tests when from = 123, to = 456
	# EDGE CASE
	def test_via_empty_string
		assert_equal 'Fifth Ave', @driver.via(123, 456)
	end

	# Tests when from = nil, to = nil
	# EDGE CASE
	def test_via_empty_string
		assert_equal 'Fifth Ave', @driver.via(nil, nil)
	end

	# Tests wheb from = 'avc', to = 'dsads'
	# invalid/unknown combination
	def test_via_empty_string
		assert_equal 'Fifth Ave', @driver.via('avc','dsads')
	end


	# UNIT TESTS FOR METHOD get_next()
	# This method only sets a new value for 'current_place'
	# and increments corresponding values based on the new value
	# returns nil
	def test_get_next
		refute_nil @driver.get_next
	end

	# UNIT TESTS FOR METHOD update_values(next_loc)
	# This method will increase @book by 1 if next_loc='Hillman'
	# This method will increase @toy by 1 if next_loc='Museum'
	# This method will increase @classes by a factor of 2 if next_loc='Cathedral'

	def test_update_values_book
		cs = CitySim.new 0

		def cs.get_next; 'Hillman'; end

		cs.update_values(cs.get_next)
		assert_equal cs.books, 1
		
	end


	def test_update_values_toy
		cs = CitySim.new 0

		def cs.get_next; 'Museum'; end

		cs.update_values(cs.get_next)
		assert_equal cs.toy, 1
		
	end

	def test_update_values_classes
		cs = CitySim.new 0

		def cs.get_next; 'Cathedral'; end

		cs.update_values(cs.get_next)
		assert_equal cs.classes, 2
		
	end


	# UNIT TESTS FOR METHOD results()
	# Always prints the values of books, toy, and classes
	# No failure cases
	def test_print_result
		assert_nil @driver.results
	end


end