class CommentsController < ApplicationController
    before_filter :load_commentable, except: [:index]

  def index
    @comments = Comment.all

  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    if params[:link_id]
      @commentable = Link.find(params[:link_id])
      @comment = @commentable.comments.new
    elsif params[:comment_id]
      @commentable = Comment.find(params[:comment_id])
      @comment = @commentable.comments.new
    end
  end

  def create
    if params[:link_id]
      @commentable = Link.find(params[:link_id])
    elsif params[:comment_id]
      @commentable = Comment.find(params[:comment_id])
    end
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      flash[:notice] = "Comment was added."
      redirect_to comments_path
    else
      render 'new'
    end
  end

  # def get_master
  #   @parent = @comment.commentable
  #   if @parent.respond_to?('commentable_type')
  #     @comment = @parent
  #     get_master
  #   else
  #     return @parent
  #   end
  # end

  private



    def comment_params
      params.require(:comment).permit(:content, :user_id, :link_id, :comment_id)
    end

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    # @commentable = resource.singularize.classify.constantize.find(id)
  end

end
