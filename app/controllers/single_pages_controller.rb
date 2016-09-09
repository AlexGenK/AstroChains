# контроллер обрабатывающий единичные страницы
class SinglePagesController < ApplicationController
  def about
  end

  def libraries
    @tags=ActsAsTaggableOn::Tag.all
  end

  def addlibraries
    @tag=ActsAsTaggableOn::Tag.new(:name=>params[:addlib].mb_chars.downcase)
    @tag.save
    redirect_to '/libraries'
  end

  def dellibraries
    @t=ActsAsTaggableOn::Tag.where('taggings_count=0').delete_all
    redirect_to '/libraries'
  end

end
