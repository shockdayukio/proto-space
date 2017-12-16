class TagsController < ApplicationController

  def index
    @tags = tag.most_used
  end

  def show
    @tag = tag.find(tag_params[:id])
    @prototypes_count = Prototype.tagged_with(@tag).length
    @prototypes = Prototype.tagged_with(@tag.name).includes(:user, :tags).page(@tag.name).per(Prototype::NUMBER_OF_DISPLAYED_PROTOTYPES)
  end

  private
  def tag_params
    params.permit(:id)
  end

  def tag
    ActsAsTaggableOn::Tag
  end
end
