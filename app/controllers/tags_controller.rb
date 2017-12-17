class TagsController < ApplicationController

  def index
    @tags = ActsAsTaggableOn::Tag.most_used
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find_by(name: tag_params[:name])
    @prototypes_count = Prototype.tagged_with(@tag).length
    @prototypes = Prototype.tagged_with(@tag.name).includes(:user, :tags).page(@tag.name).per(Prototype::NUMBER_OF_DISPLAYED_PROTOTYPES)
  end

  private
  def tag_params
    params.permit(:name)
  end
end
