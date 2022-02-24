require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  #create
  describe 'Comment #create' do
    let!(:my_post) { FactoryBot.create(:post) }

    context "with invalid parameters" do
      it 'return status 400(without essential parmas creator)' do
        post "/post/#{my_post.id}/comment", {content: "test content"}
        expect(response).to have_http_status(:bad_request)
      end

      it 'return status 400(without essential parmas content)' do
        post "/post/#{my_post.id}/comment", {creator: "test creator"}
        expect(response).to have_http_status(:bad_request)
      end

      it 'return status 400(params is not number)' do
        post "/post/notnumbertest/comment", {content:"test content", creator: "test creator"}
        expect(response).to have_http_status(:bad_request)
      end

      it 'return status 400(params is not number)' do
        post "/post/55555/comment", {content:"test content", creator: "test creator"}
        expect(response).to have_http_status(:not_found)
      end
    end

    context "with valid parameters" do
      it 'return status 400(params is not number)' do
        post "/post/#{my_post.id}/comment", {content:"test content", creator: "test creator"}
        expect(response).to have_http_status(:ok)
      end
    end
  end


  ##update
  describe 'Comment #update' do
    context "with invalid query params" do
      it 'return status 400(params is not number)' do
        put '/comment/notnumbertest'
        expect(response).to have_http_status(:bad_request)
      end

      it 'return status 404(post is not exist)' do
        put '/comment/555555'
        expect(response).to have_http_status(:not_found)
      end
    end

    context "valid query params" do
      let!(:my_comment) { FactoryBot.create(:comment) }

      it 'returns status code 200' do
        put "/comment/#{my_comment.id}", {content: "change comment"}
        expect(json["content"]).to eq("change comment")
      end
    end
  end


  ##delete
  describe 'Comment #delete' do
    let!(:comment) { FactoryBot.create(:comment) }

    before do
      delete "/comment/#{comment.id}"
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end

