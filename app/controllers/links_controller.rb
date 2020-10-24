class LinksController < ApplicationController
  before_action :authenticate_user!, :linkable

  def new
    @link = Link.new
  end

  def create
    @link = Link.create(link_params)
    if @link.persisted?
      redirect_to path_success
    else
      flash[:alert] = @link.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    @link = Link.find params[:id]
    @link.destroy!
    redirect_to path_success
  end

  private

  def link_params
    params.require(:link).permit(:url).merge(linkable: linkable)
  end
end
