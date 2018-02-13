require_relative 'vagon'
require_relative 'manufacturer'

class CargoVagon < Vagon
  attr_accessor :volume, :free_volume

  def initialize(vol)
    @volume = vol
    @free_volume = vol
  end

  def take_volume(vol)
    @free_volume -= vol if (free_volume - vol) > 0
  end

  def occupied_volume
    volume - free_volume
  end

  def to_s
    "Тип - Грузовой. Объём: свободный #{free_volume}, занятый #{occupied_volume}"
  end
end
