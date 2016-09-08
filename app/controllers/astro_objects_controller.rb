# контроллер обрабатывающий астрологические объекты для которых строятся цепочки диспозиций
class AstroObjectsController < ApplicationController

  def index
    @taglist=ActsAsTaggableOn::Tag.all
    params[:search]='' if params[:commit]=='Показать все'
    # если передана подстрока поиска то выводятся лишь те объекты, в названии которых существует данная подстрока
    # как в капитализированном, так и в обычном виде
    if params[:search]
      if params[:library]==""
        @astro_objects=AstroObject.where('name LIKE ? OR name LIKE ?', "%#{params[:search].mb_chars.capitalize.to_s}%", "%#{params[:search].mb_chars.downcase.to_s}%").paginate(:page=>params[:page]).order(:name)
      else
        @astro_objects=AstroObject.tagged_with(params[:library]).where('name LIKE ? OR name LIKE ?', "%#{params[:search].mb_chars.capitalize.to_s}%", "%#{params[:search].mb_chars.downcase.to_s}%").paginate(:page=>params[:page]).order(:name)
      end
    else
      if params[:library]==""
        @astro_objects=AstroObject.paginate(:page=>params[:page]).order(:name)
      else
        @astro_objects=AstroObject.tagged_with(params[:library]).paginate(:page=>params[:page]).order(:name)
      end
    end
    # запоминаем текущую страницу в глобальной переменной
    @@current_page=params[:page]
  end

  def new
    @astro_object=AstroObject.new
  end

  def create
    # если при создании объекта была нажата кнопка Отменить, то возвращаемся на текущую страницу индекса.
    # иначе сохраняем созданный объект
    if params[:commit]=="Отменить"
      redirect_to action: 'index', page: @@current_page||=1
    else
      @astro_object=AstroObject.new(astro_object_params)
      if @astro_object.save
        redirect_to astro_objects_path
      else
        render action: 'new'
      end
    end
  end

  def show
    @astro_object=AstroObject.find(params[:id])
    @chains=@astro_object.chains.all
  end

  def edit
    @astro_object=AstroObject.find(params[:id])
  end

  def update
    # если при редактировании объекта была нажата кнопка Отменить, то возвращаемся на текущую страницу индекса.
    # иначе сохраняем ищмененный объект
    if params[:commit]=="Отменить"
      redirect_to action: 'index', page: @@current_page||=1
    else
      @astro_object=AstroObject.find(params[:id])
      if params[:commit]=="Tag"
        @astro_object.tag_list.add "tagged"
      end
      if @astro_object.update(astro_object_params)
        redirect_to @astro_object
      else
        render action: 'edit'
      end
    end
  end

  def destroy

    # перед удалением объекта удаляются также все изображеня цепочек диспозиций этого объекта, если они существуют
    Chain.where(astro_object_id: params[:id]).each do |item|
      File.delete("app/assets/images/graphs/#{item.id}.png") if File.exist?("app/assets/images/graphs/#{params[:id]}.png")
    end
    
    AstroObject.find(params[:id]).destroy
    redirect_to astro_objects_path
  end

  private

  # разрешение передачи параметров
  def astro_object_params
    params.require(:astro_object).permit(:name, :date, :time, :comment, :tag_list)
  end


end
