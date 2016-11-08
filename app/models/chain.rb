# модель - цепочка диспозиций построенная для какого-либо объекта
class Chain < ActiveRecord::Base

  # константа в которой хранятся названия планет, соответствующие им префиксы в модели цепочки
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
            {:planet_name=>'Плутон', :planet_prefix=>'plu', :planet_symbol=>'Z'},
            {:planet_name=>'Юж. центр', :planet_prefix=>'smn', :planet_symbol=>'m'},
            {:planet_name=>'Сев. центр', :planet_prefix=>'nmn', :planet_symbol=>'M'},
            {:planet_name=>'Хирон', :planet_prefix=>'chi', :planet_symbol=>'e'},
            {:planet_name=>'Прозерпина', :planet_prefix=>'pro', :planet_symbol=>'d'},
            ].freeze

  belongs_to :astro_object

  # метод, визуализирующий цепочку в виде графа с помощью библиотеки GraphWiz. принимает имя файла в который будет производится визуализация
  def graph_create(image_name)

    # создается объект-направленный граф
    g = GraphViz::new( "G", "rankdir" => direction, :use => visualization )
    graph_nodes=[]
    
    # если цепочка строится по септенеру, количество планет ограничивается семью. иначе - девять
    nodes_count = septener ? 6 : 13
    
    # в зависимости от выбранного стиля визуализации центров, определяется цвет рамки, выделяющей центры,
    # и цвет элементов находящихся в центрах
    if center_style=="frame"
      frame_color="red"
      element_color="black"
    else
      frame_color="white"
      element_color="red"
    end

    # параметры цепочки просматриваеюся, и в графе создается необходимое количество кластеров
    0.upto nodes_count do |i|
      pl_center=eval("#{PLANETS[i][:planet_prefix]}_center")
      if pl_center>0 
        instance_variable_set("@c#{pl_center}", g.add_graph("cluster#{pl_center}"))
        eval("@c#{pl_center}")["color"]=frame_color
      end 
    end

    # проходим цикл по всем планетам для формирования узлов графа
    0.upto nodes_count do |i|
      # для планеты вытаскиваем префикс, символ в шрифте, вес в графе и признак ретроградности
      pl_prefix=PLANETS[i][:planet_prefix]
      pl_symbol=PLANETS[i][:planet_symbol]
      pl_weigth=eval("#{pl_prefix}_weigth")
      pl_retro=eval("#{pl_prefix}_retro")
      # если планета в основных - создаем узел сразу. если нет, то проверяем признак наличия
      if (i<=9) || (eval("#{pl_prefix}_exist"))
        # формируем строку, которая в описании узла-планеты в графе отвечает за вес
        pl_weigth_string = pl_weigth ? "<font color='forestgreen' point-size='20'>#{pl_weigth}</font>" : ''

        # формируем строку, которая в описании узла-планеты в графе отвечает за ретроградность
        pl_retro_string = pl_retro ? "<font color='black' point-size='20'>N</font>" : ''

        # узнаем, принадлежит ли планета к какому-либо кластеру и добавляем узел-планету к соответствующему кластеру
        pl_center=eval("#{pl_prefix}_center")
        case pl_center
        when 0
          graph_nodes[i]=g.add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='25'>#{pl_symbol}#{pl_retro_string}#{pl_weigth_string}</font>>")
        when 1..6
          graph_nodes[i]=eval("@c#{pl_center}").add_nodes(pl_prefix, :label=>"<<font face='astro-semibold' point-size='25'>#{pl_symbol}#{pl_retro_string}#{pl_weigth_string}</font>>", :color=>element_color)
        end
      end
    end
    
    nodes_count = septener ? 6 : 9
    # снова проходим по всем планетам для создания связей между узлами графа
    0.upto nodes_count do |i|
      # определяем с какой планетой связана планета
      pl_relation=eval("#{PLANETS[i][:planet_prefix]}_relation")
      # если связь есть, то создаем
      if eval("#{PLANETS[i][:planet_prefix]}_center")>0
        edge_color=element_color
      else
        edge_color="black"
      end
      # создание связи
      g.add_edges(graph_nodes[i], graph_nodes[pl_relation], :color=>edge_color, :len=>"1.2") if pl_relation<100
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
