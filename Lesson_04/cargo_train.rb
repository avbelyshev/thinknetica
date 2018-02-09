require_relative 'train'
require_relative 'cargo_vagon'

class CargoTrain < Train
  def vagon_class
    CargoVagon
  end

  def to_s
    "№ #{self.number}. Тип - Грузовой"
  end
end
