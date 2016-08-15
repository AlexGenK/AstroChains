class AstroObjectsController < ApplicationController

  def index
    @astro_objects=AstroObject.order(:name)
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
