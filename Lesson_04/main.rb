require_relative "station"
require_relative "route"
require_relative "train"
require_relative "passenger_train"
require_relative "cargo_train"
require_relative "vagon"
require_relative "passenger_vagon"
require_relative "cargo_vagon"
require_relative "db_record"
require_relative "interface"

db_record = DBRecord.new

interface = Interface.new(db_record)

interface.open
