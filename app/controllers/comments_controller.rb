class CommentsController < ApplicationController

  before_filter :authenticate, :only => :destroy 
  before_filter :permit_comment_params, :only => [:create]

  def create
    @post = Post.find(params[:post_id])
    #@comment = @post.comments.create(params[:comment])
	  @comment = @post.comments.create(permit_comment_params)
    redirect_to post_path(@post)
  end

  def destroy
  	@post = Post.find(params[:post_id])
  	@comment=Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.json { head :no_content }
    end
  end

  private

  def permit_comment_params
  	params[:comment].permit(:commenter,:body)
  end

end
