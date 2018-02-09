class Train
  attr_reader :number, :vagons, :speed, :route, :current_station_number

  def initialize(number)
    @number = number
    @vagons = []
    @speed = 0
  end

  def brake
    @speed = 0
  end

  def moving?
    @speed > 0
  end

  def add_vagon(vagon)
    return if moving? || !valid_vagon_type?(vagon)
    vagons << vagon
  end

  def delete_vagon(vagon)
    return if moving?
    vagons.delete(vagon)
  end

  def set_route(route)
    current_station.send_train(self) unless @route.nil?

    @route = route
    @current_station_number = 0
    current_station.add_train(self)
  end

  def move_forward
    return unless next_station_number
    current_station.send_train(self)
    next_station.add_train(self)
    @current_station_number = next_station_number
  end

  def move_back
    return unless previous_station_number
    current_station.send_train(self)
    previous_station.add_train(self)
    @current_station_number = previous_station_number
  end

  def current_station
    @route.stations[@current_station_number]
  end

  def next_station
    @route.stations[next_station_number]
  end

  def previous_station
    @route.stations[previous_station_number]
  end

  protected

  # Служебные методы для получения индекса станции, клиент работает с объектами класса Station
  def next_station_number
    @current_station_number + 1 unless @current_station_number == @route.stations.size - 1
  end

  def previous_station_number
    @current_station_number - 1 unless @current_station_number == 0
  end

  def vagon_class
  end

  def valid_vagon_type?(vagon)
    vagon.kind_of?(vagon_class)
  end
end
