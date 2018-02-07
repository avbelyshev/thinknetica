require_relative 'train'
require_relative 'cargo_vagon'

class CargoTrain < Train

  private

  def valid_vagon_type?(vagon)
    vagon.kind_of?(CargoVagon)
  end
end
