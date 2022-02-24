class CommentController < ApplicationController

  #댓글 쓰기
  def write
    raise Error::BadRequest unless is_number(params[:post_id])
    raise Error:: BadRequest unless check_not_nil_all(params[:creator], params[:content])
    raise Error:: NotFound unless Post.exists?(id: params[:post_id])
    comment = CommentService.create(params)
    render json: comment, status: :ok
  end

  #댓글 수정
  def update
    raise Error::BadRequest unless is_number(params[:comment_id])
    raise Error:: NotFound unless Comment.exists?(id:params[:comment_id])
    comment = CommentService.update(params)
    render json: comment, status: :ok
  end

  # 글 삭제
  def delete
    raise Error::BadRequest unless is_number(params[:comment_id])
    raise Error:: NotFound unless Comment.exists?(id:params[:comment_id])
    Comment.destroy(params[:comment_id])
    render json: {}, status: :ok
  end

end
