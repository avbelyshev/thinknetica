class Train
  attr_reader :number, :type, :vagon_count, :speed, :route, :station_number

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
    return if moving? || @vagon_count == 0
    @vagon_count -= 1
  end

  def set_route(route)
    station_by_number&.send_train(self) unless route.nil?

    @route = route
    @station_number = 0
    station_by_number.add_train(self)
  end

  def move_forward
    station_by_number&.send_train(self)
    next_station&.add_train(self)
  end

  def move_back
    station_by_number&.send_train(self)
    previous_station&.add_train(self)
  end

  def station_by_number
    route_check

    @route.stations[@station_number]
  end

  def next_station
    return if @station_number == @route.stations.size - 1
    @station_number += 1
    station_by_number
  end

  def previous_station
    return if @station_number == 0
    @station_number -= 1
    station_by_number
  end

  def route_check
    raise "Маршрут не задан! Вызов метода запрещен." if route.nil?
  end
end
