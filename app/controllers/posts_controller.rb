include SessionHelper
class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  skip_before_action :require_login, only: %i[index show]
  before_action :author_or_admin, only: %i[edit destroy update]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(**post_params, author: @current_user.id)

    can_save = !@post.title&.empty? && !@post.text&.empty?
    respond_to do |format|
      if can_save && @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity, alert: 'Empty title or text field' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    can_save = !post_params[:title]&.empty? && !post_params[:text]&.empty? && is_author_or_admin?
    respond_to do |format|
      if can_save && @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add
    respond_to do |format|
      format.json { render json: @post }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
    @author = @post.author.nil? ? nil : User.find(@post.author)
  end

    # Only allow a list of trusted parameters through.
  def post_params
    par = params.require(:post).permit(:title)
    txt = params.require(:text).map do |str|
      unless str.empty?
        if str.starts_with?('http')
          "<img>#{str}</img>\n"
        else
          "<text>#{str}</text>\n"
        end
      end
    end
                .join('')
    params = ActionController::Parameters.new(post: {
      title: par[:title],
      text: txt
    })
    params.require(:post).permit(:title, :text)
  end

  def author_or_admin
    unless @current_user.id == @post&.author || @current_user&.role == 'admin'
      redirect_to root_url
    end
  end

  def is_author_or_admin?
    @current_user.id == @post&.author || @current_user&.role == 'admin'
  end
end
