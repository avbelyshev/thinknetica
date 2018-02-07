require_relative "db_record"

class Interface

  MENU = [
    "Создать станцию",
    "Создать поезд",
    "Создать маршрут",
    "Добавить станцию в маршрут",
    "Удалить станцию из маршрута",
    "Назначить маршрут поезду",
    "Добавить вагон к поезду",
    "Отцепить вагон от поезда",
    "Переместить поезд вперед",
    "Переместить поезд назад",
    "Посмотреть список станций",
    "Посмотреть список поездов на станции",
    "Выход"
  ]

  def initialize(db_record)
    @db_record = db_record
  end

  def open
    loop do
      puts "Меню действий:\n"
      MENU.each.with_index(1) do |item, index|
        puts "#{index}. #{item}\n"
      end

      user_choice = gets.to_i

      case user_choice
        when 1 then create_station
        when 2 then create_train
        when 3 then create_route
        when 4 then add_station_to_route
        when 5 then delete_station_from_route
        when 6 then set_route_to_train
        when 7 then add_vagon_to_train
        when 8 then delete_vagon_from_train
        when 9 then move_train_forward
        when 10 then move_train_back
        when 11 then view_stations_list
        when 12 then view_trains_list_at_station
        when 13 then break
        else puts "В меню действий нет такого пункта."
      end
    end
  end

  private

  attr_reader :db_record

  def create_station
    puts "Создание станции.\n"
    puts "Введите название станции:\n"
    station_name = gets.chomp

    db_record.create_station(station_name)
  end

  def create_train
    puts "Создание поезда.\n"
    puts "Введите номер поезда:\n"
    train_num = gets.to_i
    puts "Выберите тип поезда (0 - пассажирский, 1 - грузовой):\n"
    train_type = gets.to_i

    db_record.create_train(train_num, train_type)
  end

  def create_route
    puts "Создание маршрута.\n"

    start = station_select(" начальную ")
    final = station_select(" конечную ")

    db_record.create_route(start, final)
  end

  def add_station_to_route
    puts "Добавление станции в маршрут.\n"
    route_num = route_select
    station_num = station_select

    db_record.add_station_to_route(route_num, station_num)
  end

  def delete_station_from_route
    puts "Удаление станции из маршрута.\n"
    route_num = route_select
    station_num = station_select

    db_record.delete_station_from_route(route_num, station_num)
  end

  def set_route_to_train
    puts "Назначение маршрута поезду.\n"
    train_num = train_select
    route_num = route_select

    db_record.set_route_to_train(train_num, route_num)
  end

  def add_vagon_to_train
    puts "Добавление вагона к поезду\n"
    train_num = train_select

    db_record.add_vagon_to_train(train_num)
  end

  def delete_vagon_from_train
    puts "Отцепка вагона от поезда\n"
    train_num = train_select
    vagon_num = vagon_select(train_num)

    db_record.delete_vagon_from_train(train_num, vagon_num)
  end

  def move_train_forward
    puts "Перемещение поезда вперед\n"
    train_num = train_select

    db_record.move_train_forward(train_num)
  end

  def move_train_back
    puts "Перемещение поезда назад\n"
    train_num = train_select

    db_record.move_train_back(train_num)
  end

  def view_stations_list
    db_record.stations.each.with_index(1) do |station, index|
      puts "#{index}. #{station.name}\n"
    end
  end

  def view_trains_list_at_station
    station_num = station_select

    db_record.stations[station_num].trains.each do |train|
      puts "#{train.to_s}\n"
    end
  end

  def view_route_list
    db_record.routes.each.with_index(1) do |route, index|
      puts "#{index}. #{route.to_s}\n"
    end
  end

  def view_trains_list
    db_record.trains.each.with_index(1) do |train, index|
      puts "#{index}. #{train.to_s}\n"
    end
  end

  def station_select(str = ' ')
    puts "Выберите#{str}станцию:\n"
    view_stations_list
    station_num = gets.to_i - 1
  end

  def route_select
    puts "Выберите маршрут:\n"
    view_route_list
    route_num = gets.to_i - 1
  end

  def train_select
    puts "Выберите поезд:\n"
    view_trains_list
    train_num = gets.to_i - 1
  end

  def vagon_select(train_num)
    puts "Выберите вагон:\n"
    db_record.trains[train_num].vagons.each.with_index(1) do |vagon, index|
      puts "#{index}\n"
    end

    vagon_num = gets.to_i - 1
  end
end
