require_relative 'train'
require_relative 'passenger_vagon'
require_relative 'manufacturer'

class PassengerTrain < Train
  def vagon_class
    PassengerVagon
  end

  def capacity_message
    "Задайте кол-во мест в вагоне"
  end

  def to_s
    "№ #{self.number}. Тип - Пассажирский. Кол-во вагонов: #{vagons.size}"
  end
end
