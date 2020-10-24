class Profile::IssuesController < ApplicationController
  before_action :authenticate_user!

  def show
    @issue = Issue.find_by_id params[:id]
    @supports = current_user.supports.where_issue(@issue)
      .order(:preference)
      .preload(:position)
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.find_or_initialize_by(issue_params)
    @adoption = Adoption.new(profile: current_user.profile, issue: @issue)
    handle_create
  end

  def edit
    @issue = Issue.find params[:id]
  end

  def update
    @issue = Issue.find params[:id]
    if @issue.update issue_params
      redirect_to issue_path(@issue), notice: 'Issue successfully updated'
    else
      flash[:alert] = @issue.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:name, :outline)
  end

  def handle_create
    if @issue.persisted? && @adoption.save
      redirect_to issue_path(@issue),
        notice: 'New issue adopted'
    elsif @issue.save && @adoption.save
      redirect_to issue_path(@issue),
        notice: 'New issue created'
    else
      handle_create_error
    end
  end

  def handle_create_error
    flash[:alert] = @issue.errors.full_messages.to_sentence +
                    @adoption.errors.full_messages.to_sentence
    render :new
  end
end
