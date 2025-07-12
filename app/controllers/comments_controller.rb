class CommentsController < ApplicationController
  before_action :set_prototype, only: [:create, :show]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@prototype)
    else
      @comments = @prototype.comments.includes(:user)
      render 'prototypes/show'
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  private

  def set_prototype
    # showアクションでは :id、createアクションでは :prototype_id が使われる
    @prototype = Prototype.find(params[:id] || params[:prototype_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :prototype).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
