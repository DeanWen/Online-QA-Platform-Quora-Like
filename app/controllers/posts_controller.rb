class PostsController < ApplicationController
  skip_before_action :authorize, only: [:index,:show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  #before_filter :authenticate, :except => [:index, :show] 
  
  
  # /posts          params[:user_id] => nil
  # /users/10/posts params[:user_id] => 10

  def index
    @posts = Post.user_id(params[:user_id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml {render :xml => @posts}
    end
  end

  # GET /posts/1
  # GET /posts/1.json

  # GET /posts/new
  def new
    @post = Post.new
      respond_to do |format|
      format.html # new.html.erb
      format.xml {render :xml => @posts}
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end


  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params[:post].merge!(:name => User.find(session[:user_id]).to_s, :user_id => session[:user_id])
      params.require(:post).permit(:name, :title, :user_id, :content,:tags_attributes=>[:name,:id,:_destroy])
    end

end
