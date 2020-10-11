class LinksController < ApplicationController
  before_action :authenticate_user!, :issue

  def new
    @link = Link.new
  end

  def create
    @link = Link.create(link_params)
    if @link.persisted?
      redirect_to issue_path(@issue)
    else
      flash[:alert] = @link.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    @link = Link.find params[:id]
    @link.destroy!
    redirect_to issue_path(@issue)
  end

  private

  def link_params
    params.require(:link).permit(:url).merge(linkable: issue)
  end

  def issue
    @issue ||= Issue.find params[:issue_id]
  end
end
