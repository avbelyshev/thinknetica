require_relative 'vagon'
require_relative 'manufacturer'

class PassengerVagon < Vagon
  attr_accessor :places, :free_places

  def initialize(places)
    @places = places
    @free_places = places
  end

  def take_place
    @free_places -= 1 if free_places > 0
  end

  def occupied_places
    places - free_places
  end

  def to_s
    "Тип - Пассажирский. Кол-во мест: свободно #{free_places}, занято #{occupied_places}"
  end
end
