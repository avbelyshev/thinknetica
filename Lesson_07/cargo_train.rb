require_relative 'train'
require_relative 'cargo_vagon'
require_relative 'manufacturer'

class CargoTrain < Train
  def vagon_class
    CargoVagon
  end

  def capacity_message
    "Задайте объём вагона"
  end

  def to_s
    "№ #{self.number}. Тип - Грузовой. Кол-во вагонов: #{vagons.size}"
  end
end
