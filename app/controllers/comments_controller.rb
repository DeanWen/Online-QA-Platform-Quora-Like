class CommentsController < ApplicationController

  #before_filter :authenticate, :only => :destroy
  before_filter :get_username_and_permit_comment_params, :only => [:create]

  def create
    @post = Post.find(params[:post_id])
	  @comment = @post.comments.create(get_username_and_permit_comment_params)

    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
  	@comment = current_user.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.json { head :no_content }
    end
  end

  private

  def get_username_and_permit_comment_params
    params[:comment].merge!(:commenter => User.find(session[:user_id]).to_s,:user_id => session[:user_id])
  	params[:comment].permit(:commenter, :body, :user_id)
  end

end
