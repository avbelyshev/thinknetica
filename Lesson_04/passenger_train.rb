require_relative 'train'
require_relative 'passenger_vagon'

class PassengerTrain < Train
  def vagon_class
    PassengerVagon
  end

  def to_s
    "№ #{self.number}. Тип - Пассажирский"
  end

  private

  def valid_vagon_type?(vagon)
    vagon.kind_of?(PassengerVagon)
  end
end
