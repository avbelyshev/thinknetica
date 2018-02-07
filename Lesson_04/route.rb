class Route
  attr_reader :stations

  def initialize(start, final)
    @stations = [start, final]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station) unless [stations[0], stations[-1]].include?(station)
  end
end
