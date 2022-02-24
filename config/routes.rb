Rails.application.routes.draw do

  #post

  #글 리스트
  get '/post' => 'post#list'
  #글 상세
  get '/post/:post_id' => 'post#detail'
  #글 작성
  post '/post' => 'post#write'
  #글 수정
  put '/post/:post_id' => 'post#update'
  #글 삭제
  delete '/post/:post_id' => 'post#delete'


  #comment

  #댓글 작성
  post '/post/:post_id/comment' => 'comment#write'
  #댓글 수정
  put '/comment/:comment_id' => 'comment#update'
  #댓글 삭제
  delete '/comment/:comment_id' => 'comment#delete'


  #error => static page

  get '/404', to: 'error#not_found'
  get '/422', to: 'error#unprocessable'
  get '/500', to: 'error#internal_server'

end