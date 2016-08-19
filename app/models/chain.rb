# модель - цепочка диспозиций построенная для какого-либо объекта

class Chain < ActiveRecord::Base
  belongs_to :astro_object
end
