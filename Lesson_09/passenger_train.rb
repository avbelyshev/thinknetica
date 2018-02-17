require_relative 'train'
require_relative 'passenger_vagon'
require_relative 'manufacturer'

class PassengerTrain < Train
  validate :number, :presence
  validate :number, :format, NUM_PATTERN

  def vagon_class
    PassengerVagon
  end

  def to_s
    "№ #{number}. Тип - Пассажирский. Кол-во вагонов: #{vagons.size}"
  end
end
