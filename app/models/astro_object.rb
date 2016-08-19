# модель - объект для которого будут строится цепочки диспозиций

class AstroObject < ActiveRecord::Base
  has_many :chains
end
