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

  # метод, визуализирующий цепочку в виде графа с помощью библиотеки GraphWiz. принимает имя файла в который будет производится визуализация
  def graph_create(image_name)

    # создается объект-направленный граф
    g = GraphViz::new( "G", "rankdir" => direction, :use => visualization )
    graph_nodes=[]
    
    # если цепочка строится по септенеру, количестdо планет ограничивается семью. иначе - девять
    if septener
      end_planet=6
    else
      end_planet=9
    end

    # параметры цепочки просматриваеюся, и в графе создается необходимое количество кластеров
    0.upto end_planet do |i|
      pl_center=eval("#{PLANETS[i][:planet_prefix]}_center")
      case pl_center
      when 1
        @c1=g.add_graph("cluster1")
        @c1["color"]="red"
      when 2
        @c2=g.add_graph("cluster2")
        @c2["color"]="red"
      when 3
        @c3=g.add_graph("cluster3")
        @c3["color"]="red"
      when 4
        @c4=g.add_graph("cluster4")
        @c4["color"]="red"
      when 5
        @c5=g.add_graph("cluster5")
        @c5["color"]="red"
      when 6
        @c6=g.add_graph("cluster6")
        @c6["color"]="red"
      end
    end

    # проходим цикл по всем планетам для формирования узлов графа
    0.upto end_planet do |i|
      # для планеты вытаскиваем префикс, символ в шрифте, вес в графе и признак ретроградности
      pl_prefix=PLANETS[i][:planet_prefix]
      pl_symbol=PLANETS[i][:planet_symbol]
      pl_weigth=eval("#{pl_prefix}_weigth")
      pl_retro=eval("#{pl_prefix}_retro")

      # формируем строку, которая в описании узла-планеты в графе отвечает за вес
      if pl_weigth==nil
        pl_weigth_string=''
      else
        pl_weigth_string="<font color='forestgreen' point-size='20'>#{pl_weigth}</font>"
      end

      # формируем строку, которая в описании узла-планеты в графе отвечает за ретроградность
      if pl_retro
        pl_retro_string="<font color='black' point-size='20'>N</font>"
      else
        pl_retro_string=''
      end

      # узнаем, принадлежит ли планета к какому-либо кластеру и добавляем узел-планету к соответствующему кластеру
      pl_center=eval("#{pl_prefix}_center")
      case pl_center
      when 0
        graph_nodes[i]=g.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='25'>#{pl_symbol}#{pl_weigth_string}#{pl_retro_string}</font>>")
      when 1
        graph_nodes[i]=@c1.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='25'>#{pl_symbol}#{pl_weigth_string}#{pl_retro_string}</font>>")
      when 2
        graph_nodes[i]=@c2.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='25'>#{pl_symbol}#{pl_weigth_string}#{pl_retro_string}</font>>")
      when 3
        graph_nodes[i]=@c3.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='25'>#{pl_symbol}#{pl_weigth_string}#{pl_retro_string}</font>>")
      when 4
        graph_nodes[i]=@c4.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='25'>#{pl_symbol}#{pl_weigth_string}#{pl_retro_string}</font>>")
      when 5
        graph_nodes[i]=@c5.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='25'>#{pl_symbol}#{pl_weigth_string}#{pl_retro_string}</font>>")   
      when 6
        graph_nodes[i]=@c6.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='25'>#{pl_symbol}#{pl_weigth_string}#{pl_retro_string}</font>>")
      end
    end

    # снова проходим по всем планетам для создания связей между узлами графа
    0.upto end_planet do |i|
      # определяем с какой планетой связана планета
      pl_relation=eval("#{PLANETS[i][:planet_prefix]}_relation")
      # если связь есть, то создаем
      g.add_edges(graph_nodes[i], graph_nodes[pl_relation]) if pl_relation<100
    end
    
    # собственно визуализация графа в файл
    g.output(:png => "public/images/chaingraphs/#{image_name}.png")
  end

  # метод, принмает хэш с параметрами цепочки и определяет соответсвует ли он параметрам по септенеру
  def self.septener?(chain_params)
      0.upto 6 do |i|
        planet_relation_number=chain_params["#{PLANETS[i][:planet_prefix]}_relation"].to_i
        return false if (planet_relation_number > 6) && (planet_relation_number < 100)
      end
      return true
  end

end
