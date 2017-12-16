class TagsController < ApplicationController

  def index
    @tags = tag.most_used
  end

  def show
    @tag = tag.find(params[:id])
    @prototypes_count = Prototype.tagged_with(@tag).length
    @prototypes = Prototype.tagged_with(@tag).includes(:user, :taggings).page(params[:page]).per(Prototype::NUMBER_OF_DISPLAYED_PROTOTYPES)
  end

  private
  def tag_params
    params.permit[:id]
  end

  def tag
    ActsAsTaggableOn::Tag
  end
end
