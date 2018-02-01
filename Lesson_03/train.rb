class Train
  attr_reader :number, :type
  attr_accessor :vagon_count, :speed, :route, :station_number

  def initialize(number, type, vagon_count = 0)
    @number = number
    @type = type
    @vagon_count = vagon_count
  end

  def brake
    @speed = 0
  end

  def moving?
    @speed > 0
  end

  def add_vagon
    return if moving?
    @vagon_count += 1
  end

  def delete_vagon
    return if moving?
    @vagon_count -= 1 if @vagon_count > 0
  end

  def set_route(route)
    current_station.send_train(self)

    @route = route
    @route.stations[0].add_train(self)
    @station_number = 0
  end

  def move_forward
    if next_station
      current_station.send_train(self)
      @station_number = next_station
      current_station.add_train(self)
    end
  end

  def move_back
    if previous_station
      current_station.send_train(self)
      @station_number = previous_station
      current_station.add_train(self)
    end
  end

  def current_station
    @route.stations[@station_number]
  end

  def next_station
    @station_number + 1 unless @station_number == @route.stations.size - 1
  end

  def previous_station
    @station_number - 1 unless @station_number == 0
  end
end
