class AstroObjectsController < ApplicationController

  def index
  end

  def new
  end

  def create
    @astro_object=AstroObject.new(astro_object_params)
    if @astro_object.save
      render action: 'create'
    else
      render action: 'new'
    end
  end

  private

  # разрешение передачи параметров
  def astro_object_params
    params.require(:astro_object).permit(:name, :date, :time, :comment)
  end


end
