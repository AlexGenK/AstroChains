# модель - цепочка диспозиций построенная для какого-либо объекта
class Chain < ActiveRecord::Base

  # константа в кторой хранятся названия планет, соответствующие им префиксы в модели цепочки
  # и символ которым они кодируются в специальном шрифте 'astro'
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

  # метод, визуализирующий цепочку в виде графа с помощью библиотеки GraphWiz. принмает хэш с параметрами
  # цепочки (в соответствии с моделью) и имя файла в который будет производится визуализация
  def self.graph_create(chain_params, image_name)

    # создается объект-направленный граф с тремя кластерами
    g = GraphViz::new( "G", "rankdir" => "LR" )
    graph_nodes=[]
    c1=g.add_graph("cluster1")
    c1["color"]="red"
    c2=g.add_graph("cluster2")
    c2["color"]="red"
    c3=g.add_graph("cluster3")
    c3["color"]="red"

    # если цепочка строится по септенеру, количесвто планет ограничивается семью. иначе - девять
    if chain_params[:septener]=='1'
      end_planet=6
    else
      end_planet=9
    end

    # проходим цикл по всем планетам для формирования узлов графа
    0.upto end_planet do |i|
      # для планеты вытаскиваем префикс, символ в шрифте, вес в графе и признак ретроградности
      pl_prefix=PLANETS[i][:planet_prefix]
      pl_symbol=PLANETS[i][:planet_symbol]
      pl_weigth=chain_params["#{pl_prefix}_weigth"].to_i
      pl_retro=chain_params["#{pl_prefix}_retro"].to_i

      # формируем строку, которая в описании узла-планеты в графе отвечает за вес
      if pl_weigth==0
        pl_weigth_string=''
      else
        pl_weigth_string="<font color='forestgreen' point-size='20'>#{pl_weigth}</font>"
      end

      # формируем строку, которая в описании узла-планеты в графе отвечает за ретроградность
      if pl_retro==0
        pl_retro_string=''
      else
        pl_retro_string="<font color='black' point-size='20'>N</font>"
      end

      # узнаем, принадлежит ли планета к какому-либо кластеру и добавляем узел-планету к соответствующему кластеру
      pl_center=chain_params["#{pl_prefix}_center"]
      case pl_center
      when '0'
        graph_nodes[i]=g.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='25'>#{pl_symbol}#{pl_weigth_string}#{pl_retro_string}</font>>")
      when '1'
        graph_nodes[i]=c1.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='25'>#{pl_symbol}#{pl_weigth_string}#{pl_retro_string}</font>>")
      when '2'
        graph_nodes[i]=c2.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='25'>#{pl_symbol}#{pl_weigth_string}#{pl_retro_string}</font>>")
      else
        graph_nodes[i]=c3.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='25'>#{pl_symbol}#{pl_weigth_string}#{pl_retro_string}</font>>")
      end
    end

    # снова проходим по всем планетам для создания связей между узлами графа
    0.upto end_planet do |i|
      # определяем с какой планетой связана планета
      pl_relation=chain_params["#{PLANETS[i][:planet_prefix]}_relation"].to_i
      # если связь есть, то создаем
      g.add_edges(graph_nodes[i], graph_nodes[pl_relation]) if pl_relation<100
    end
    
    # собственно визуализация графа в файл
    g.output(:png => "app/assets/images/graphs/#{image_name}.png")
  end

  def reset
    PLANETS.each do |item|
      self.send("#{item[:planet_prefix]}_retro=", false)
      self.send("#{item[:planet_prefix]}_weigth=", nil)
      self.send("#{item[:planet_prefix]}_center=", 0)
      self.send("#{item[:planet_prefix]}_relation=", 100)
    end
  end

end
