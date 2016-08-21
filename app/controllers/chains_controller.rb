class ChainsController < ApplicationController

  def new
    @astro_object=AstroObject.find(params[:astro_object_id])
  end

  def create
    @astro_object=AstroObject.find(params[:astro_object_id])
    @chain=@astro_object.chains.new(chain_params)
    @chain.code=params[:sol_relation]
    @chain.save
    redirect_to @astro_object
  end

  def destroy
    Chain.find(params[:id]).destroy
    redirect_to AstroObject.find(params[:astro_object_id])
  end

  private

  # разрешение передачи параметров
  def chain_params
    params.require(:chain).permit(:kind, :code, :image, :comment)
  end
end
