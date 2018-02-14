require_relative 'train'
require_relative 'passenger_vagon'
require_relative 'manufacturer'

class PassengerTrain < Train
  def vagon_class
    PassengerVagon
  end

  def to_s
    "№ #{number}. Тип - Пассажирский. Кол-во вагонов: #{vagons.size}"
  end
end
