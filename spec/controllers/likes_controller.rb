require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let!(:user) { create :user }
  before { sign_in user }

  describe '#create' do
    subject { process :create, method: :post, params: params }

    let(:params) { { like: { likeable_id: likeable.id, likeable_type: likeable.class } } }

    let(:likeable) { create :post, user: user }
    it 'user creates a like on post' do
      expect { subject }.to change(Like, :count).by(1)
    end

    let(:likeable) { create :comment, user: user }
    it 'user creates a like on comment' do
      expect { subject }.to change(Like, :count).by(1)
    end
  end

  describe '#destroy' do
    subject { process :destroy, method: :delete, params: params }

    let!(:likeable_) { create :post, user: user }
    let!(:like) { create :like, user: user, likeable: likeable_ }
    let(:params) { { id: like.id } }

    it 'user deletes like' do
      expect { subject }.to change(Like, :count).by(-1)
    end
  end
end
