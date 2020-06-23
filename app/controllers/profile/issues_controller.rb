class Profile::IssuesController < ApplicationController
  before_action :authenticate_user!

  def show
    @issue = Issue.find_by_identifier params[:id]
    @positions = current_user.positions.where_issue @issue
    @adoption = current_user.adoptions.find_by issue: @issue
    render 'issues/show'
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.find_or_initialize_by(issue_params)
    @adoption = Adoption.new(profile: current_user.profile, issue: @issue)
    handle_create
  end

  private

  def issue_params
    params.require(:issue).permit(:name)
  end

  def handle_create
    if @issue.persisted? && @adoption.save
      redirect_to profile_issue_path(@issue),
        notice: 'New issue adopted'
    elsif @issue.save && @adoption.save
      redirect_to profile_issue_path(@issue),
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
