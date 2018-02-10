require_relative "storage"

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

  def initialize(storage)
    @storage = storage
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

  attr_reader :storage

  def create_station
    puts "Создание станции.\n"
    puts "Введите название станции:\n"

    station_name = gets.chomp

    storage.create_station(station_name)
  end

  def create_train
    puts "Создание поезда.\n"
    puts "Введите номер поезда:\n"

    train_num = gets.to_i
    if storage.train?(train_num)
      puts "Поезд с данным номером уже есть."
      return
    end

    puts "Выберите тип поезда (0 - пассажирский, 1 - грузовой):\n"

    train_type = gets.to_i
    if storage.wrong_train_type?(train_type)
      puts "Некорректный тип поезда."
      return
    end

    storage.create_train(train_num, train_type)
  end

  def create_route
    if storage.stations.size < 2
      puts "Для создания маршрута необходимо создать несколько станций."
      return
    end

    puts "Создание маршрута.\n"

    start = choose_item(storage.stations, "Выберите начальную станцию:\n")
    return unless correct_station(start)

    final = choose_item(storage.stations, "Выберите конечную станцию:\n")
    return unless correct_station(final)

    if start == final
      puts "Начальная и конечная точки маршрута должны быть разными."
      return
    end

    storage.create_route(start, final)
  end

  def add_station_to_route
    puts "Добавление станции в маршрут.\n"

    route_num = choose_item(storage.routes, "Выберите маршрут:\n")
    return unless correct_route(route_num)

    station_num = choose_item(storage.stations, "Выберите станцию:\n")
    return unless correct_station(station_num)

    storage.add_station_to_route(route_num, station_num)
  end

  def delete_station_from_route
    puts "Удаление станции из маршрута.\n"

    route_num = choose_item(storage.routes, "Выберите маршрут:\n")
    return unless correct_route(route_num)

    station_num = choose_item(storage.stations, "Выберите станцию:\n")
    return unless correct_station(station_num)

    storage.delete_station_from_route(route_num, station_num)
  end

  def set_route_to_train
    puts "Назначение маршрута поезду.\n"

    train_num = choose_item(storage.trains, "Выберите поезд:\n")
    return unless correct_train(train_num)

    route_num = choose_item(storage.routes, "Выберите маршрут:\n")
    return unless correct_route(route_num)

    storage.set_route_to_train(train_num, route_num)
  end

  def add_vagon_to_train
    puts "Добавление вагона к поезду\n"

    train_num = choose_item(storage.trains, "Выберите поезд:\n")
    return unless correct_train(train_num)

    storage.add_vagon_to_train(train_num)
  end

  def delete_vagon_from_train
    puts "Отцепка вагона от поезда\n"

    train_num = choose_item(storage.trains, "Выберите поезд:\n")
    return unless correct_train(train_num)

    vagon_num = choose_item(storage.trains[train_num].vagons, "Выберите вагон:\n")

    storage.delete_vagon_from_train(train_num, vagon_num)
  end

  def move_train_forward
    puts "Перемещение поезда вперед\n"

    train_num = choose_item(storage.trains, "Выберите поезд:\n")
    return unless correct_train(train_num)

    storage.move_train_forward(train_num)
  end

  def move_train_back
    puts "Перемещение поезда назад\n"

    train_num = choose_item(storage.trains, "Выберите поезд:\n")
    return unless correct_train(train_num)

    storage.move_train_back(train_num)
  end

  def view_collection(collection)
    collection.each.with_index(1) do |item, index|
      puts "#{index}. #{item}\n"
    end
  end

  def view_stations_list
    puts "Список станций:\n"

    view_collection(storage.stations)
  end

  def view_trains_list_at_station
    station_num = choose_item(storage.stations, "Выберите станцию:\n")
    return unless correct_station(station_num)

    station = storage.stations[station_num]

    puts "Поезда на станции #{station.name}:\n"

    view_collection(station.trains)
  end

  def choose_item(collection, display_message)
    puts display_message
    view_collection(collection)
    item_num = gets.to_i - 1
  end

  # Уберу эти методы когда доберемся до исключений
  def correct_station(station_num)
    if storage.stations[station_num].nil?
      puts "Станция с данным номером не найдена."
      false
    else
      true
    end
  end

  def correct_route(route_num)
    if storage.routes[route_num].nil?
      puts "Маршрут с данным номером не найден."
      false
    else
      true
    end
  end

  def correct_train(train_num)
    if storage.trains[train_num].nil?
      puts "Поезд с данным номером не найден."
      false
    else
      true
    end
  end
end
