# модель - цепочка диспозиций построенная для какого-либо объекта

class Chain < ActiveRecord::Base

  PLANETS=[ {:planet_name=>'Солнце', :planet_prefix=>'sun'},
            {:planet_name=>'Луна', :planet_prefix=>'moo'},
            {:planet_name=>'Меркурий', :planet_prefix=>'mer'},
            {:planet_name=>'Венера', :planet_prefix=>'ven'},
            {:planet_name=>'Марс', :planet_prefix=>'mar'},
            {:planet_name=>'Юпитер', :planet_prefix=>'jup'},
            {:planet_name=>'Сатурн', :planet_prefix=>'sat'},
            {:planet_name=>'Уран', :planet_prefix=>'ura'},
            {:planet_name=>'Нептун', :planet_prefix=>'nep'},
            {:planet_name=>'Плутон', :planet_prefix=>'plu'},
            ].freeze

  belongs_to :astro_object

end
