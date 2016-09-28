# контроллер обрабатывающий астрологические объекты для которых строятся цепочки диспозиций
class AstroObjectsController < ApplicationController

  def index
    @taglist=ActsAsTaggableOn::Tag.all.order(:name)
    params[:search]='' if params[:commit]=='Показать все'
    # текущая библиотека сохраняется в сессии
    params[:library]=session[:library] if ( !params[:library] ) && session[:library]
    params[:library]="" if ( !params[:library] ) && ( !session[:library] )
    session[:library]=params[:library]
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
    @taglist=ActsAsTaggableOn::Tag.all.order(:name)
    @astro_object=AstroObject.new
  end

  def create
    # если при создании объекта была нажата кнопка Отменить, то возвращаемся на текущую страницу индекса.
    # иначе сохраняем созданный объект
    if params[:commit]=="Отменить"
      redirect_to action: 'index', page: @@current_page||=1
    else
      @astro_object=AstroObject.new(astro_object_params)
      # запись библиотек-тегов присвоенных объекту
      if params[:library] 
        @astro_object.tag_list = params[:library].join(',')
      else
        @astro_object.tag_list = ''
      end
      # запись объекта и обработка ошибок
      if @astro_object.save
        redirect_to @astro_object
      else
        flash[:alert]="Имя объекта не должно быть пустым"
        @taglist=ActsAsTaggableOn::Tag.all.order(:name)
        render action: 'new'
      end
    end
  end

  def show
    @astro_object=AstroObject.find(params[:id])
    @taglist=@astro_object.tag_list.sort
    @chains=@astro_object.chains.all
  end

  def edit
    @taglist=ActsAsTaggableOn::Tag.all.order(:name)
    @astro_object=AstroObject.find(params[:id])
  end

  def update
    # если при редактировании объекта была нажата кнопка Отменить, то возвращаемся на текущую страницу индекса.
    # иначе сохраняем иpмененный объект
    if params[:commit]=="Отменить"
      redirect_to action: 'index', page: @@current_page||=1
    else
      @astro_object=AstroObject.find(params[:id])
      # запись библиотек-тегов присвоенных объекту
      if params[:library] 
        @astro_object.tag_list = params[:library].join(',')
      else
        @astro_object.tag_list = ''
      end
      if @astro_object.update(astro_object_params)
        redirect_to action: 'index', page: @@current_page||=1
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
    params.require(:astro_object).permit(:name, :date, :time, :comment, :tag_list, :birthplace)
  end

end
