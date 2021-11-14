class ActsAsTaggableOn::TagsController < ApplicationController
    def index
        @tag=ActsAsTaggableOn::Tag.new
        @tags=ActsAsTaggableOn::Tag.order(:name)
    end

    def create
        @tag=ActsAsTaggableOn::Tag.new(:name => params[:acts_as_taggable_on_tag][:name].mb_chars.downcase)
        flash[:alert]='Вы ввели недопустимое имя для библиотеки.' unless @tag.save
        redirect_to acts_as_taggable_on_tags_path
    end

    def destroy
        @tag = ActsAsTaggableOn::Tag.find(params[:id])
        @tag.destroy
        redirect_to acts_as_taggable_on_tags_path
    end

    private

    def tags_params
        params.require(:tag).permit(:name)
    end
end
