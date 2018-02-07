require_relative 'station'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_vagon'
require_relative 'cargo_vagon'

class DBRecord
  attr_reader :stations, :routes, :trains

  def initialize()
    @stations = []
    @routes = []
    @trains = []
  end

  def create_station(station_name)
  end

  def create_train(train_num, train_type)
  end

  def add_station_to_route(route_num, station_num)
  end

  def delete_station_from_route(route_num, station_num)
  end

  def set_route_to_train(train_num, route_num)
  end

  def add_vagon_to_train(train_num)
  end

  def delete_vagon_from_train(train_num, vagon_num)
  end

  def move_train_forward(train_num)
  end

  def move_train_back(train_num)
  end
end
