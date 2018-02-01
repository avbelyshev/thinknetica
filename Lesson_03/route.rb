class Route
  attr_reader :stations

  def initialize(start, final)
    @stations = [start, final]
    @route = @stations
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station) unless @route.include?(station)
  end
end
