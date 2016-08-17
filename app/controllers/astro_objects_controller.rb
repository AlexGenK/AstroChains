class AstroObjectsController < ApplicationController

  def index
  # если передана подстрока поиска то выводятся лишь те объекты, в названии которых существует данная подстрока
    if params[:search]
      @astro_objects=AstroObject.where('name LIKE ? OR name LIKE ?', "%#{params[:search].mb_chars.capitalize.to_s}%", "%#{params[:search].mb_chars.downcase.to_s}%")
    else
      @astro_objects=AstroObject.order(:name)
    end
  end

  def new
  end

  def create
    @astro_object=AstroObject.new(astro_object_params)
    if @astro_object.save
      redirect_to astro_objects_path
    else
      render action: 'new'
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
    @astro_object=AstroObject.find(params[:id])

    if @astro_object.update(astro_object_params)
      redirect_to @astro_object
    else
      render action: 'edit'
    end
  end

  def destroy
    AstroObject.find(params[:id]).destroy
    redirect_to astro_objects_path
  end

  private

  # разрешение передачи параметров
  def astro_object_params
    params.require(:astro_object).permit(:name, :date, :time, :comment)
  end


end
