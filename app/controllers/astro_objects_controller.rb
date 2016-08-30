# контроллер обрабатывающий астрологические объекты для которых строятся цепочки диспозиций
class AstroObjectsController < ApplicationController

  def index
    params[:search]='' if params[:commit]=='Показать все'
    # если передана подстрока поиска то выводятся лишь те объекты, в названии которых существует данная подстрока
    # как в капитализированном, так и в обычном виде
    if params[:search]
      @astro_objects=AstroObject.where('name LIKE ? OR name LIKE ?', "%#{params[:search].mb_chars.capitalize.to_s}%", "%#{params[:search].mb_chars.downcase.to_s}%").paginate(:page=>params[:page]).order(:name)
    else
      @astro_objects=AstroObject.paginate(:page=>params[:page]).order(:name)
    end
    @@current_page=params[:page]
  end

  def new
    @astro_object=AstroObject.new
  end

  def create
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
    if params[:commit]=="Отменить"
      redirect_to action: 'index', page: @@current_page||=1
    else
      @astro_object=AstroObject.find(params[:id])
      if @astro_object.update(astro_object_params)
        redirect_to @astro_object
      else
        render action: 'edit'
      end
    end
  end

  def destroy

    # перед удалением объекта удаляются также все изображеня цепочек диспозиций этого объекта
    Chain.where(astro_object_id: params[:id]).each do |item|
      File.delete("app/assets/images/graphs/#{item.id}.png")
    end
    
    AstroObject.find(params[:id]).destroy
    redirect_to astro_objects_path
  end

  private

  # разрешение передачи параметров
  def astro_object_params
    params.require(:astro_object).permit(:name, :date, :time, :comment)
  end


end
