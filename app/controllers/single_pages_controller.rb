# контроллер обрабатывающий единичные страницы
class SinglePagesController < ApplicationController

  def about
  end

  # просмотр тегов-библиотек
  def libraries
    @tags=ActsAsTaggableOn::Tag.all
  end

  # добавление библиотеки
  def addlibraries
    @tag=ActsAsTaggableOn::Tag.new(:name=>params[:addlib].mb_chars.downcase)
    flash[:alert]='Вы ввели недопустимое имя для библиотеки.' unless @tag.save
    redirect_to '/libraries'
  end

  # удаление пустых библиотек
  def dellibraries
    @t=ActsAsTaggableOn::Tag.where('taggings_count=0').delete_all
    redirect_to '/libraries'
  end

end
