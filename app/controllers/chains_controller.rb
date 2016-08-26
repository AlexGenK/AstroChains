class ChainsController < ApplicationController

  def new
    @astro_object=AstroObject.find(params[:astro_object_id])
    @chain=@astro_object.chains.build
    @preview_name=''
  end

  def create
    @astro_object=AstroObject.find(params[:astro_object_id])
    @chain=@astro_object.chains.new(chain_params)
    @chain.code=params.to_s

    if params[:commit]=='Просмотреть'
      @preview_name='preview'
      Chain.graph_create(chain_params, @preview_name)
      render action: 'new'
    else
      @chain.save
      @preview_name=@chain.id.to_s
      Chain.graph_create(chain_params, @preview_name)
      redirect_to @astro_object
    end
  end

  def destroy
    Chain.find(params[:id]).destroy
    redirect_to AstroObject.find(params[:astro_object_id])
  end

  def edit
    @astro_object=AstroObject.find(params[:astro_object_id])
    @chain=Chain.find(params[:id])
    @preview_name=@chain.id.to_s
  end

  def update
    @astro_object=AstroObject.find(params[:astro_object_id])
    @chain=Chain.find(params[:id])

    if params[:commit]=='Просмотреть'
      @preview_name=@chain.id.to_s
      Chain.graph_create(chain_params, @preview_name)
      @chain.update(chain_params)
      render action: 'edit'
    else
      if @chain.update(chain_params)
        redirect_to @astro_object
      else
        render action: 'edit'
      end
    end
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
