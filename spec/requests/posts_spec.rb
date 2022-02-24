require 'rails_helper'

RSpec.describe 'Posts', type: :request do

  ##create
  describe 'POST #create' do
    let!(:my_post) { FactoryBot.create(:post) }

    context "with invalid parameters" do
      before do
        @without_title = { creator: my_post.creator, content: my_post.content }
        @without_creator = { title: my_post.title, content: my_post.content }
        @without_content = { title: my_post.title, creator: my_post.creator }
      end

      it 'return status 400(without essential parmas title)' do
        post '/post', @without_title
        expect(response).to have_http_status(:bad_request)
      end

      it 'return status 400(without essential parmas creator)' do
        post '/post', @without_creator
        expect(response).to have_http_status(:bad_request)
      end

      it 'return status 400(without essential parmas content)' do
        post '/post', @without_content
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with valid parameters' do
      before do
        post '/post',  { title: my_post.title, creator: my_post.creator, content: my_post.content  }
      end

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'return title' do
        expect(json['title']).to eq(my_post.title)
      end

      it 'return creator' do
        expect(json['creator']).to eq(my_post.creator)
      end

      it 'return content' do
        expect(json['content']).to eq(my_post.content)
      end
    end
  end


  ##read
  describe 'POST #read' do
    before do
      FactoryBot.create(:post, title: '취준이 모집합니다.', creator: '취준이', content: '아무내용' )
      FactoryBot.create(:post, title: '모집합니다.', creator: '취준이', content: '아무내용')
      FactoryBot.create(:post, title: '취준이 모집합니다222.', creator: '취준이2', content: '아무내용')
      FactoryBot.create(:post, title: '모집합니다22.', creator: '취준이2', content: '아무내용')
      FactoryBot.create(:post, title: '테스트제목', creator: '테스트작성자', content: '아무내용')
    end

    context "without query params" do
      before do
        get '/post'
      end

      it 'return all posts' do
        expect(json.count).to eq(5)
      end

      it 'returns status 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context "with query params" do
      context "include query params: title" do
        it 'include title: 취준이' do
          get URI.parse(URI.encode('/post?title=취준이'))
          json.each do |key, value|
            expect(key["title"]).to include("취준이")
          end
        end
      end

      context "include query params: creator" do
        it 'include title: 취준이' do
          get URI.parse(URI.encode('/post?creator=취준이'))
          json.each do |key, value|
            expect(key["creator"]).to eq("취준이")
          end
        end
      end

      context "include query params: title, creator" do
        it 'include title, creator: 취준이, ' do
          get URI.parse(URI.encode('/post?creator=취준이&title=취준이'))
          json.each do |key, value|
            expect(key["title"]).to include("취준이")
            expect(key["creator"]).to eq("취준이")
          end
        end
      end

      context "include query params: sort" do
        it 'updated_at sort after update title ' do
          put '/post/3', {title: "change title post3"}
          get '/post?sort=updated_at'
          expect(json.first["title"]).to eq("change title post3")
        end
      end
    end
  end


  ##detail
  describe 'POST #detail' do
    before do
      FactoryBot.create_list(:post, 10)
    end

    context "with invalid query params" do
      it 'return status 400(params is not number)' do
        get '/post/notnumbertest'
        expect(response).to have_http_status(:bad_request)
      end

      it 'return status 404(post is not exist)' do
        get '/post/555555'
        expect(response).to have_http_status(:not_found)
      end
    end

    ##comment라는 녀석이 오는지 안오는지 확인해야 합니다.

    context "valid query params" do
      it 'returns status code 200' do
        get '/post/3'
        expect(response).to have_http_status(:success)
      end
    end
  end

  ##update
  describe 'POST #update' do
    before do
      FactoryBot.create_list(:post, 10)
    end

    context "with invalid query params" do
      it 'return status 400(params is not number)' do
        put '/post/notnumbertest'
        expect(response).to have_http_status(:bad_request)
      end

      it 'return status 404(post is not exist)' do
        put '/post/555555'
        expect(response).to have_http_status(:not_found)
      end
    end

    context "valid query params" do
      it 'returns status code 200' do
        put '/post/3', {title: "change title post3"}
        get '/post?sort=updated_at'
        expect(json.first["title"]).to eq("change title post3")
      end
    end
  end

  ##delete
  describe 'POST #delete' do
    let!(:post) { FactoryBot.create(:post) }

    before do
      delete "/post/#{post.id}"
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end