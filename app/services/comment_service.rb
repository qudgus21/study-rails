module CommentService
  module_function

  #생성
  def create(params)
    comment = Comment.new
    comment.creator = params[:creator]
    comment.content = params[:content]
    comment.post_id = params[:post_id]
    comment.save
    return comment
  end

  #수정
  def update(params)
    comment = Comment.find(params[:comment_id])
    params[:creator].nil? || (comment.creator = params[:creator])
    params[:content].nil? ||  (comment.content = params[:content])
    comment.save()
    return comment
  end

end