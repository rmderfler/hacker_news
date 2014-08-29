class VotesController < ApplicationController
  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      flash[:notice] = "Vote was added."
      redirect_to links_path
    else
      render 'new'
    end
  end

  private
    def vote_params
      params.require(:vote).permit(:user_id, :link_id)
    end
end
