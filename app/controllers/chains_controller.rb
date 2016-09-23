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
    @preview_name=''
    # проверка созданной цепочки на соответствие требованиям септенера
    if (chain_params[:septener]=='1') && (!Chain.septener?(chain_params))
      flash[:alert]="Цепочка составлена не по септенеру. Перегенерируйте цепочку."
      render action: 'new'
      return
    end

    # клонируем хеш параметров, чтобы впоследствии его можно было изменить
    edited_params=chain_params.clone
    # если в форме был нажата кнопка просмотра или сброса, то цепочка создается, визуализируется с именем 'preview', 
    # но не записывается и снова вводится форма создания цепочки.
    # в обратном случае цепочка записывается, визуализируется с именем-id объекта и выводится форма просмотра
    # объекта к которому принадлежит цепочка
    if (params[:commit]=='Просмотреть')||(params[:commit]=='Сбросить')
      @preview_name='preview'
      # если была нажата кнопка Сбросить, то сбрасываем хэш параметров к исходным значениям
      if params[:commit]=='Сбросить'
        reset_params! edited_params
      end
      # меняем атрибуты цепочки без ее записи и визуализируем ее
      @chain.assign_attributes(edited_params)
      @chain.graph_create(@preview_name)
      render action: 'new'
    else
      @chain.save
      @preview_name=@chain.id.to_s
      @chain.graph_create(@preview_name)
      redirect_to @astro_object
    end
  end

  def destroy
    Chain.find(params[:id]).destroy
    # после удаления цепочки удаляется и файл с ее визуализацией, если он существует
    File.delete("/public/images/chaingraphs/#{params[:id]}.png") if File.exist?("/public/images/chaingraphs/#{params[:id]}.png")
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
    @preview_name='preview'
    # клонируем хеш параметров, чтобы впоследствии его можно было изменить
    edited_params=chain_params.clone
    # меняем атрибуты цепочки без ее записи
    @chain.assign_attributes(edited_params)
    if (chain_params[:septener]=='1') && (!Chain.septener?(chain_params))
      @preview_name=@chain.id.to_s
      flash[:alert]="Цепочка составлена не по септенеру. Перегенерируйте цепочку."
      render action: 'edit'
      return
    end
    @chain.graph_create(@preview_name)
    # если в форме был нажата кнопка просмотра или сброса, то цепочка меняется, визуализируется с именем-id цепочки, 
    # но не записывается и снова вводится форма редактирования цепочки.
    # в обратном случае происходит то же самое, но цепочка сохраняется и выводится форма просмотра объекта 
    # к которому принадлежит цепочка
    if (params[:commit]=='Просмотреть')||(params[:commit]=='Сбросить')
      # если была нажата кнопка Сбросить, то сбрасываем хэш параметров к исходным значениям
      if params[:commit]=='Сбросить'
        reset_params! edited_params
        @chain.assign_attributes(edited_params)
        @chain.graph_create(@preview_name)
      end
      # меняем атрибуты цепочки без ее записи
      @chain.assign_attributes(edited_params)
      render action: 'edit'
    else
      if @chain.update(chain_params)
        @preview_name=@chain.id.to_s
        @chain.graph_create(@preview_name)
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
                                                                              :plu_retro, :plu_weigth, :plu_center, :plu_relation,
                                  :direction, :visualization, :center_style)
  end

  # сброс хэша параметров цепочки к исходным значениям
  def reset_params! params
    Chain::PLANETS.each do |item|
      params["#{item[:planet_prefix]}_retro"]="0"
      params["#{item[:planet_prefix]}_weigth"]=nil
      params["#{item[:planet_prefix]}_center"]="0"
      params["#{item[:planet_prefix]}_relation"]="100"
    end
  end

end
