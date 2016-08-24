class ChainsController < ApplicationController

  def new
    @astro_object=AstroObject.find(params[:astro_object_id])
    @chain=@astro_object.chains.build
  end

  def create

    @astro_object=AstroObject.find(params[:astro_object_id])
    @chain=@astro_object.chains.new(chain_params)
    @chain.code=params.to_s

    if params[:commit]=='Просмотреть'
      render action: 'new'
    else
      @chain.save
      redirect_to @astro_object
    end

  end

  def destroy
    Chain.find(params[:id]).destroy
    redirect_to AstroObject.find(params[:astro_object_id])
  end

  private

  # разрешение передачи параметров
  def chain_params
    params.require(:chain).permit(:kind, :code, :image, :comment, :septener)
  end
  
end
