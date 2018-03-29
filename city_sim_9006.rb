require_relative 'city_sim'

# main function
raise 'Only 1 integer argument needed, no more no less.' unless ARGV.count == 1
seed = ARGV[0].to_i
(1..5).each do |i|
  if seed.nil?
    rng = Random.new seed + i
    driver = CitySim.new i, rng
  else
    driver = CitySim.new i
  end
  while driver.current_place != 'Outside'
    next_loc = driver.next_location
    driver.update_values next_loc
  end
  driver.results
end
