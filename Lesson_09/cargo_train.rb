require_relative 'train'
require_relative 'cargo_vagon'
require_relative 'manufacturer'

class CargoTrain < Train
  validate :number, :presence
  validate :number, :format, NUM_PATTERN

  def vagon_class
    CargoVagon
  end

  def to_s
    "№ #{number}. Тип - Грузовой. Кол-во вагонов: #{vagons.size}"
  end
end
