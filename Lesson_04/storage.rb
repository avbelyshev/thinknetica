require_relative 'station'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_vagon'
require_relative 'cargo_vagon'

class Storage
  TRAIN_TYPES = [PassengerTrain, CargoTrain]

  attr_reader :stations, :routes, :trains

  def initialize()
    @stations = []
    @routes = []
    @trains = []
  end

  def create_station(station_name)
    stations << Station.new(station_name)
  end

  def create_train(train_num, train_type)
    train_class = TRAIN_TYPES[train_type]
    trains << train_class.new(train_num)
  end

  def create_route(start, final)
    routes << Route.new(stations[start], stations[final])
  end

  def add_station_to_route(route_num, station_num)
    routes[route_num].add_station(stations[station_num])
  end

  def delete_station_from_route(route_num, station_num)
    routes[route_num].delete_station(stations[station_num])
  end

  def set_route_to_train(train_num, route_num)
    trains[train_num].set_route(routes[route_num])
  end

  def add_vagon_to_train(train_num)
    train = trains[train_num]
    vagon_class = train.vagon_class
    train.add_vagon(vagon_class.new)
  end

  def delete_vagon_from_train(train_num, vagon_num)
    train = trains[train_num]
    train.delete_vagon(train.vagons[vagon_num])
  end

  def move_train_forward(train_num)
    trains[train_num].move_forward
  end

  def move_train_back(train_num)
    trains[train_num].move_back
  end

  def train_types
    TRAIN_TYPES
  end

  def train?(train_num)
    trains.find { |t| t.number == train_num }
  end

  def wrong_train_type?(train_type)
    train_types[train_type].nil?
  end

  def wrong_station?(station_num)
    stations[station_num].nil?
  end

  def wrong_route?(route_num)
    routes[route_num].nil?
  end

  def wrong_train?(train_num)
    trains[train_num].nil?
  end
end
