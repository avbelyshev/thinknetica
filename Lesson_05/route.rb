require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(start, final)
    @stations = [start, final]
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station) unless [stations[0], stations[-1]].include?(station)
  end

  def to_s
    "#{stations[0].name} -> #{stations[-1].name}"
  end
end
