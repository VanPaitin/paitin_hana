class PostsController < PaitinHana::BaseController
  def new
    @post = Post.new
  end

  def create
    post_params = params[:post]
    @post = Post.new
    @post.title = post_params["title"]
    @post.body = post_params["body"]
    @post.created_at = Time.now
  end
end
