# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    if current_user&.admin?
      @post = Post.new
    else
      redirect_to root_path, alert: t(:admin_alert)
    end
  end

  def edit
    if current_user&.admin?
      @post = Post.find(params[:id])
    else
      redirect_to root_path, alert: t(:admin_alert)
    end
  end

  def create
    if current_user&.admin?
      @post = Post.new(post_params)

      if @post.save
        redirect_to @post, notice: t(:'posts.post_created')
      else
        render 'new', status: :unprocessable_entity
      end
    else
      redirect_to root_path, alert: t(:admin_alert)
    end
  end

  def update
    if current_user&.admin?
      @post = Post.find(params[:id])

      if @post.update(post_params)
        redirect_to @post, notice: t(:'posts.post_updated')
      else
        render 'edit', status: :unprocessable_entity
      end
    else
      redirect_to root_path, alert: t(:admin_alert)
    end
  end

  def destroy
    if current_user&.admin?
      @post = Post.find(params[:id])
      @post.destroy

      redirect_to posts_path, notice: t(:'posts.post_deleted')
    else
      redirect_to root_path, alert: t(:admin_alert)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :published)
  end
end
