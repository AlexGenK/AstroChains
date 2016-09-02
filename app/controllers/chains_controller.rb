# контроллер обрабатывающий цепочки диспозиций
class ChainsController < ApplicationController

  def new
    @astro_object=AstroObject.find(params[:astro_object_id])
    # создается пустой объект-цепочка, прчием имя графического файла с его отображением - пустое
    @chain=@astro_object.chains.build
    @preview_name=''
  end

  def create
    @astro_object=AstroObject.find(params[:astro_object_id])
    @chain=@astro_object.chains.new(chain_params)
    @chain.code=params.to_s
    # если в форме был нажата кнопка просмотра, то цепочка создается и визуализируется с именем 'preview', 
    # но не записывается и снова вводится форма создания цепочки.
    # в обратном случае цепочка записывается, визуализируется с именем-id объекта и выводится форма просмотра
    # объекта к котрому принадлежит цепочка
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
    # после удаления цепочки удаляется и файл с ее визуализацией, если он существует
    File.delete("app/assets/images/graphs/#{params[:id]}.png") if File.exist?("app/assets/images/graphs/#{params[:id]}.png")
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
    @preview_name=@chain.id.to_s
    Chain.graph_create(chain_params, @preview_name)
    # если в форме был нажата кнопка просмотра, то цепочка меняется, визуализируется с именем-id цепочки, 
    # и снова вводится форма редактирования цепочки.
    # в обратном случае происходит то же самое, но выводится форма просмотра объекта к котрому принадлежит цепочка
    if params[:commit]=='Просмотреть'
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
