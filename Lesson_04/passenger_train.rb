require_relative 'train'
require_relative 'passenger_vagon'

class PassengerTrain < Train

  private

  def valid_vagon_type?(vagon)
    vagon.kind_of?(PassengerVagon)
  end
end
