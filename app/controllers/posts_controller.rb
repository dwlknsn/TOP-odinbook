class PostsController < ApplicationController
  before_action :set_post, only: %i[ edit update destroy ]

  def index
    @my_posts = Post.includes([ :likes, author: :profile ]).followed_by(current_user).order(created_at: :desc)
    @discoverable_posts = Post.includes([ :likes, author: :profile ]).discoverable_by(current_user).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(author: :profile).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.authored_posts.new(post_params)

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
        redirect_to @post, notice: "Post was successfully updated."
    else
        render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!

    redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed."
  end

  private

    def set_post
      @post ||= current_user.authored_posts.find(params.expect(:id))
    end

    def post_params
      params.expect(post: [ :title, :content ])
    end
end
