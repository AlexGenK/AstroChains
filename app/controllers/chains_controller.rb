class ChainsController < ApplicationController

  def new
    @astro_object=AstroObject.find(params[:astro_object_id])
    @chain=@astro_object.chains.build
  end

  def create

    @astro_object=AstroObject.find(params[:astro_object_id])
    @chain=@astro_object.chains.new(chain_params)
    @chain.code=params.to_s
    Chain.graph_create(chain_params)

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
    params.require(:chain).permit(:kind, :code, :image, :comment, :septener,  :sun_retro, :sun_weigth, :sun_center, :sun_relation,
                                                                              :moo_retro, :moo_weigth, :moo_center, :moo_relation,
                                                                              :mer_retro, :mer_weigth, :mer_center, :mer_relation,
                                                                              :ven_retro, :ven_weigth, :ven_center, :ven_relation,
                                                                              :mar_retro, :mar_weigth, :mar_center, :mar_relation,
                                                                              :jup_retro, :jup_weigth, :jup_center, :jup_relation,
                                                                              :sat_retro, :sat_weigth, :sat_center, :sat_relation,
                                                                              :ura_retro, :ura_weigth, :ura_center, :ura_relation,
                                                                              :nep_retro, :nep_weigth, :nep_center, :nep_relation,
                                                                              :plu_retro, :plu_weigth, :plu_center, :plu_relation)
  end
  
end
