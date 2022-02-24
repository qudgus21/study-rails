require 'rails_helper'

RSpec.describe Post, :type => :model do

  it "모델 생성 성공 해야 함" do
    expect(Post.new).to be_valid
  end

  it "모델 저장 성공 해야 함" do
    post = FactoryBot.create(:post)
    expect(post).to be_valid
  end

end