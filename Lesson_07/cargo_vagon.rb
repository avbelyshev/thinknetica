require_relative 'vagon'
require_relative 'manufacturer'

class CargoVagon < Vagon
  attr_accessor :volume, :free_volume

  def initialize(volume)
    @volume = volume
    @free_volume = volume
  end

  def take_volume(volume)
    @free_volume -= volume if (free_volume - volume) > 0
  end

  def occupied_volume
    volume - free_volume
  end

  def to_s
    "Тип - Грузовой. Объём: свободный #{free_volume}, занятый #{occupied_volume}"
  end
end
