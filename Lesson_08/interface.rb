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
    "Занять место или объем в вагоне",
    "Переместить поезд вперед",
    "Переместить поезд назад",
    "Посмотреть список станций",
    "Посмотреть список поездов на станции",
    "Посмотреть список вагонов поезда",
    "Посмотреть список станций с поездами и вагонами",
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
        when 9 then take_space_in_vagon
        when 10 then move_train_forward
        when 11 then move_train_back
        when 12 then view_stations_list
        when 13 then view_trains_list_at_station
        when 14 then view_vagons_list
        when 15 then view_stations_list_with_trains
        when 16 then break
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
  rescue RuntimeError => e
    puts e.message
  end

  def create_train
    puts "Создание поезда.\n"
    puts "Введите номер поезда:\n"

    train_num = gets.chomp
    raise "Поезд с данным номером уже есть." if storage.train?(train_num)

    puts "Выберите тип поезда (0 - пассажирский, 1 - грузовой):\n"

    train_type = gets.to_i
    raise "Некорректный тип поезда." if storage.wrong_train_type?(train_type)

    storage.create_train(train_num, train_type)
    # puts "Создан поезд #{Train::find(train_num)}"
    puts "Создан поезд #{storage.trains.last}"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_route
    raise "Для создания маршрута необходимо создать несколько станций." if storage.stations.size < 2

    puts "Создание маршрута.\n"

    start = choose_item(storage.stations, "Выберите начальную станцию:\n")
    raise "Станция с данным номером не найдена." if storage.wrong_station?(start)

    final = choose_item(storage.stations, "Выберите конечную станцию:\n")
    raise "Станция с данным номером не найдена." if storage.wrong_station?(final)

    raise "Начальная и конечная точки маршрута должны быть разными." if start == final

    storage.create_route(start, final)
  rescue RuntimeError => e
    puts e.message
  end

  def add_station_to_route
    puts "Добавление станции в маршрут.\n"

    route_num = choose_item(storage.routes, "Выберите маршрут:\n")
    raise "Маршрут с данным номером не найден." if storage.wrong_route?(route_num)

    station_num = choose_item(storage.stations, "Выберите станцию:\n")
    raise "Станция с данным номером не найдена." if storage.wrong_station?(station_num)

    storage.add_station_to_route(route_num, station_num)
  rescue RuntimeError => e
    puts e.message
  end

  def delete_station_from_route
    puts "Удаление станции из маршрута.\n"

    route_num = choose_item(storage.routes, "Выберите маршрут:\n")
    raise "Маршрут с данным номером не найден." if storage.wrong_route?(route_num)

    station_num = choose_item(storage.stations, "Выберите станцию:\n")
    raise "Станция с данным номером не найдена." if storage.wrong_station?(station_num)

    storage.delete_station_from_route(route_num, station_num)
  rescue RuntimeError => e
    puts e.message
  end

  def set_route_to_train
    puts "Назначение маршрута поезду.\n"

    train_num = choose_item(storage.trains, "Выберите поезд:\n")
    raise "Поезд с данным номером не найден." if storage.wrong_train?(train_num)

    route_num = choose_item(storage.routes, "Выберите маршрут:\n")
    raise "Маршрут с данным номером не найден." if storage.wrong_route?(route_num)

    storage.set_route_to_train(train_num, route_num)
  rescue RuntimeError => e
    puts e.message
  end

  def add_vagon_to_train
    puts "Добавление вагона к поезду\n"

    train_num = choose_item(storage.trains, "Выберите поезд:\n")
    raise "Поезд с данным номером не найден." if storage.wrong_train?(train_num)

    if storage.trains[train_num].is_a?(CargoTrain)
      puts "Задайте объём вагона"
    else
      puts "Задайте кол-во мест в вагоне"
    end
    capacity = gets.to_i

    storage.add_vagon_to_train(train_num, capacity)
  rescue RuntimeError => e
    puts e.message
  end

  def delete_vagon_from_train
    puts "Отцепка вагона от поезда\n"

    train_num = choose_item(storage.trains, "Выберите поезд:\n")
    raise "Поезд с данным номером не найден." if storage.wrong_train?(train_num)

    vagon_num = choose_item(storage.trains[train_num].vagons, "Выберите вагон:\n")
    raise "Вагон с данным номером не найден." if storage.wrong_vagon?(train_num, vagon_num)

    storage.delete_vagon_from_train(train_num, vagon_num)
  rescue RuntimeError => e
    puts e.message
  end

  def take_space_in_vagon
    puts "Занять место или объем в вагоне\n"

    train_num = choose_item(storage.trains, "Выберите поезд:\n")
    raise "Поезд с данным номером не найден." if storage.wrong_train?(train_num)

    vagon_num = choose_item(storage.trains[train_num].vagons, "Выберите вагон:\n")
    raise "Вагон с данным номером не найден." if storage.wrong_vagon?(train_num, vagon_num)

    vagon = storage.trains[train_num].vagons[vagon_num]
    if vagon.is_a?(CargoVagon)
      puts "Введите объём"
      volume = gets.to_f
      vagon.take_volume(volume)
    else
      vagon.take_place
    end
  rescue RuntimeError => e
    puts e.message
  end

  def move_train_forward
    puts "Перемещение поезда вперед\n"

    train_num = choose_item(storage.trains, "Выберите поезд:\n")
    raise "Поезд с данным номером не найден." if storage.wrong_train?(train_num)

    storage.move_train_forward(train_num)
  rescue RuntimeError => e
    puts e.message
  end

  def move_train_back
    puts "Перемещение поезда назад\n"

    train_num = choose_item(storage.trains, "Выберите поезд:\n")
    raise "Поезд с данным номером не найден." if storage.wrong_train?(train_num)

    storage.move_train_back(train_num)
  rescue RuntimeError => e
    puts e.message
  end

  def view_collection(collection)
    collection.each.with_index(1) do |item, index|
      puts "#{index}. #{item}\n"
      yield(item) if block_given?
    end
  end

  def view_stations_list
    puts "Список станций:\n"

    view_collection(storage.stations) do |station|
      station.each_train { |train| puts "  #{train}\n" }
    end
  end

  def view_trains_list_at_station
    station_num = choose_item(storage.stations, "Выберите станцию:\n")
    raise "Станция с данным номером не найдена." if storage.wrong_station?(station_num)

    station = storage.stations[station_num]

    puts "Поезда на станции #{station.name}:\n"

    view_collection(station.trains) do |train|
      train.each_vagon { |vagon, num| puts "  #{num}. #{vagon}\n" }
    end
  rescue RuntimeError => e
    puts e.message
  end

  def view_vagons_list
    train_num = choose_item(storage.trains, "Выберите поезд:\n")
    raise "Поезд с данным номером не найден." if storage.wrong_train?(train_num)

    storage.trains[train_num].each_vagon { |vagon, num| puts "  #{num}. #{vagon}\n" }
  rescue RuntimeError => e
    puts e.message
  end

  def view_stations_list_with_trains
    puts "Список станций:\n"

    view_collection(storage.stations) do |station|
      puts "Поезда на станции #{station.name}:\n"
      station.each_train do |train|
        puts "  #{train}\n"
        train.each_vagon { |vagon, num| puts "    #{num}. #{vagon}\n" }
      end
    end
  end

  def choose_item(collection, display_message)
    puts display_message
    view_collection(collection)
    item_num = gets.to_i - 1
  end
end
