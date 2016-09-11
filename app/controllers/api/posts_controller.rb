class Api::PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy]
  before_action :authenticate_request, except: [:show, :index]

  rescue_from ActionController::ParameterMissing, with: :error_params_missing

  def create
    @post = @current_user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: { error: @post.errors }, status: :bad_request
    end
  end

  def update
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: { error: @post.errors }, status: :bad_request
    end
  end

  def destroy
    if @post
      @post.destroy
      head :ok
    else
      render json: { error: "Post not found" }, :status => 404
    end
  end

  def show
    @post = Post.find(params[:id])
    if @post
      render json: @post
    else
      render json: { error: "Post not found" }, :status => 404
    end
  end

  def index
    @posts = Post.all
    render json: @posts
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def error_params_missing
      render json: { error: "Params missing" }, status: :bad_request
    end
end
