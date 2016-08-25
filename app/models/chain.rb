# модель - цепочка диспозиций построенная для какого-либо объекта

class Chain < ActiveRecord::Base

  PLANETS=[ {:planet_name=>'Солнце', :planet_prefix=>'sun', :planet_symbol=>'Q'},
            {:planet_name=>'Луна', :planet_prefix=>'moo', :planet_symbol=>'R'},
            {:planet_name=>'Меркурий', :planet_prefix=>'mer', :planet_symbol=>'S'},
            {:planet_name=>'Венера', :planet_prefix=>'ven', :planet_symbol=>'T'},
            {:planet_name=>'Марс', :planet_prefix=>'mar', :planet_symbol=>'U'},
            {:planet_name=>'Юпитер', :planet_prefix=>'jup', :planet_symbol=>'V'},
            {:planet_name=>'Сатурн', :planet_prefix=>'sat', :planet_symbol=>'W'},
            {:planet_name=>'Уран', :planet_prefix=>'ura', :planet_symbol=>'X'},
            {:planet_name=>'Нептун', :planet_prefix=>'nep', :planet_symbol=>'Y'},
            {:planet_name=>'Плутон', :planet_prefix=>'plu', :planet_symbol=>'Z'}
            ].freeze

  belongs_to :astro_object

  def self.graph_create(chain_params, image_name)

    # logger.debug "params = #{chain_params}"
    g = GraphViz::new( "G", "rankdir" => "LR" )
    graph_nodes=[]
    c1=g.add_graph("cluster1")
    c1["color"]="red"
    c2=g.add_graph("cluster2")
    c2["color"]="red"
    c3=g.add_graph("cluster3")
    c3["color"]="red"

    if chain_params[:septener]=='1'
      end_planet=6
    else
      end_planet=9
    end

    0.upto end_planet do |i|
      pl_prefix=PLANETS[i][:planet_prefix]
      pl_symbol=PLANETS[i][:planet_symbol]
      pl_weigth=chain_params["#{pl_prefix}_weigth"].to_i
      pl_weigth=" " if pl_weigth==0
      pl_center=chain_params["#{pl_prefix}_center"]
      case pl_center
      when '0'
        graph_nodes[i]=g.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='20'>#{pl_symbol}<sub>#{pl_weigth}</sub></font>>")
      when '1'
        graph_nodes[i]=c1.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='20'>#{pl_symbol}<sub>#{pl_weigth}</sub></font>>")
      when '2'
        graph_nodes[i]=c2.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='20'>#{pl_symbol}<sub>#{pl_weigth}</sub></font>>")
      else
        graph_nodes[i]=c3.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='20'>#{pl_symbol}<sub>#{pl_weigth}</sub></font>>")
      end
    end

    0.upto end_planet do |i|
      pl_relation=chain_params["#{PLANETS[i][:planet_prefix]}_relation"].to_i
      g.add_edges(graph_nodes[i], graph_nodes[pl_relation]) if pl_relation<100
    end
    
    g.output(:png => "app/assets/images/graphs/#{image_name}.png")
  end

end
