require_relative 'manufacturer'

class Vagon
  include Manufacturer

  def to_s
    NotImplementedError
  end
end
