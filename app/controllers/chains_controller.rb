class ChainsController < ApplicationController

  def create
    @astro_object=AstroObject.find(params[:astro_object_id])
    @astro_object.chains.create(chain_params)
    redirect_to @astro_object
  end

  private

  # разрешение передачи параметров
  def chain_params
    params.require(:chain).permit(:kind, :code, :image, :comment)
  end
end
