require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'vagon'
require_relative 'passenger_vagon'
require_relative 'cargo_vagon'
require_relative 'storage'
require_relative 'interface'

storage = Storage.new

storage.create_station('station № 1')
storage.create_station('station № 2')
storage.create_station('station № 3')
storage.create_train('pas-01', 0)
storage.create_train('car-01', 1)
storage.create_route(0, 2)
storage.set_route_to_train(0, 0)
storage.set_route_to_train(1, 0)
storage.add_vagon_to_train(0, 100)
storage.add_vagon_to_train(0, 120)
storage.add_vagon_to_train(1, 500)
storage.add_vagon_to_train(1, 700)

interface = Interface.new(storage)

interface.open
