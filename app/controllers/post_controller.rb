class PostController < ApplicationController

  #글 리스트
  def list
    posts = PostService.search(params)
    render json: posts, status: :ok
  end

  #글 상세
  def detail
    raise Error::BadRequest unless ApplicationHelper.is_number(params[:post_id])
    raise Error:: NotFound unless Post.exists?(id: params[:post_id])
    post = Post.find(params[:post_id])
    comments = Comment.where(post_id: params[:post_id])
    render json: {"post"=> post, "comments"=> comments}, status: :ok
  end

  # 글 작성
  def write
    raise Error::BadRequest unless ApplicationHelper.check_not_nil_all(params[:title], params[:creator], params[:content])
    post = PostService.create(params)
    render json: post, status: :ok
  end

  # 글 수정
  def update
    raise Error::BadRequest unless ApplicationHelper.is_number(params[:post_id])
    raise Error:: NotFound unless Post.exists?(id: params[:post_id])
    post = PostService.update(params)
    render json: post, status: :ok
  end

  # 글 삭제
  def delete
    raise Error::BadRequest unless ApplicationHelper.is_number(params[:post_id])
    raise Error:: NotFound unless Post.exists?(id: params[:post_id])
    Post.destroy(params[:post_id])
    render json: {}, status: :ok
  end

end

#custrom erro updaate 전의 글 상세
# begin
#   if !is_number(params[:post_id])
#     render json: {}, status: :bad_request
#   elsif !Post.exists?(id: params[:post_id])
#     render json: {}, status: :not_found
#   else
#     post = Post.find(params[:post_id])
#     comments = Comment.where(post_id: params[:post_id])
#     render json: {"post"=> post, "comments"=> comments}, status: :ok
#   end
# rescue Exception => e
#   puts e
#   render json: {}, status: :internal_server_error
# end