class ActsAsTaggableOn::TagsController < ApplicationController
    before_action :set_tag, only: [:edit, :update, :destroy]

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
        @tag.destroy
        redirect_to acts_as_taggable_on_tags_path
    end

    def edit
    end

    def update
        @tag.update(tag_params)
        redirect_to acts_as_taggable_on_tags_path
    end

    private

    def tag_params
        params.require(:acts_as_taggable_on_tag).permit(:name)
    end

    def set_tag
        @tag = @tag = ActsAsTaggableOn::Tag.find(params[:id])
    end
end
