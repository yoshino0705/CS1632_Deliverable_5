# CS1632 Deliverable 5
# Refatoring Deliverable 2
# class for running the city sim program
class CitySim
  attr_accessor :rng, :start, :locations, :books, \
                :classes, :toy, :id, :current_place

  # constructor
  def initialize(id, rng = Random.new)
    @locations = %w[Hospital Cathedral Hillman Museum]
    @rng = rng
    @start = @locations.sample(random: Random.new(@rng.rand(100)))
    @books = 0
    @classes = 1
    @toy = 0
    @id = id
    @current_place = @start
  end

  # returns the 'via' part of the message based on the 'from' and 'to'
  def via(from, to)
    dest = { 'Hospital' => 'Foo St', 'Museum' => 'Bar St',\
             'Monroeville' => 'Fourth Ave', 'MuseumHillman' => 'Fifth Ave', \
             'HospitalHillman' => 'Foo St',\
             'MuseumCathedral' => 'Bar St', \
             'HospitalCathedral' => 'Fourth Ave' }
    return dest[to] if dest.include? to

    from_to = from + to
    return dest[from_to] \
    if dest.include? from_to

    'Fifth Ave'
  end

  # create a table for the physical map
  # loc[from] = to
  def next_location
    seed = Random.new @rng.rand
    loc = { 'Hospital' => %w[Cathedral Hillman].sample(random: seed),\
            'Cathedral' => %w[Monroeville Museum].sample(random: seed),\
            'Hillman' => %w[Downtown Hospital].sample(random: seed),\
            'Museum' => %w[Cathedral Hillman].sample }
    # get the next location
    next_loc = loc[@current_place]
    # print the direction message
    puts "Driver #{@id} heading from #{@current_place} to #{next_loc}"\
    + "via #{via(@current_place, next_loc)}."

    next_loc
  end

  # increment variables and
  # assign the next location to the current_place variable
  def update_values(next_loc)
    @books += 1 if next_loc == 'Hillman'
    @toy += 1 if next_loc == 'Museum'
    @classes *= 2 if next_loc == 'Cathedral'
    @current_place = if %w[Monroeville Downtown].include? next_loc
                       'Outside'
                     else
                       next_loc
                     end
  end

  # prints the values of books, toy, and classes
  def results
    print_books
    print_toys
    print_classes
  end

  def print_books
    plural = @books == 1 ? 's!' : '!'
    puts "Driver #{@id} obtained #{@books} book#{plural}"
  end

  def print_toys
    plural = @toy == 1 ? 's!' : '!'
    puts "Driver #{@id} obtained #{@toy} dinosaur toy#{plural}"
  end

  def print_classes
    plural = @classes == 1 ? 'es!' : '!'
    puts "Driver #{@id} attended #{@classes} class#{plural}"
  end
end
