module PostService
  module_function

  #생성
  def create(params)
    post = Post.new
    post.title = params[:title]
    post.creator = params[:creator]
    post.content = params[:content]
    post.save
    return post
  end

  #검색
  def search(params)
    posts = Post.all()
    params[:title].nil? || (posts = posts.where("title LIKE ?", "%#{params[:title]}%"))
    params[:creator].nil? || (posts = posts.where(creator: params[:creator]))
    params[:sort].nil??  (posts = posts.order('created_at DESC'))  : (posts = posts.order(params[:sort]+' DESC'))
    return posts
  end

  #수정
  def update(params)
    post = Post.find(params[:post_id])
    params[:title].nil? || (post.title = params[:title])
    params[:creator].nil? || (post.creator = params[:creator])
    params[:content].nil? ||  (post.content = params[:content])
    post.save()
    return post
  end

end