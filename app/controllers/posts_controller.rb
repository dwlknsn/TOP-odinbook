class PostsController < ApplicationController
  before_action :set_post, only: %i[ edit update destroy ]

  def index
    scope = case params[:filter]
    when "discover"
        Post.discoverable_by(current_user)
    when "following"
        Post.followed_by(current_user)
    else
        Post.followed_by(current_user)
    end

    set_page_and_extract_portion_from(
      scope.published.includes([ :likes, author: :profile ]).order(created_at: :desc),
      per_page: 5
    )

    if @page.first?
      render formats: :html
    else
      render formats: :turbo_stream
      sleep 0.5.seconds # Just to demonstrate infinite scroll loading state
    end
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
      params.expect(post: [ :title, :content, :status ])
    end
end
