class Api::CommentsController < ApplicationController
  before_action :authorize_request
  before_action :set_comment, only: [:show, :update, :destroy]
    
  def index
    @thread = DiscussionThread.find(params[:discussion_thread_id])
    @comments = @thread.comments
    render json: @comments
  end
  
  def show
    render json: @comment
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.discussion_thread_id = params[:comment][:discussion_thread_id]

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    puts "Deleting comment with ID: #{params[:id]}"
    @comment.destroy
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
    @discussion_thread = DiscussionThread.find(params[:discussion_thread_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :discussion_thread_id, :username)
  end
end
  