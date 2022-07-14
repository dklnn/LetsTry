require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
  let!(:user) { create :user }
  before { sign_in user }

  describe '#create' do
    subject { process :create, method: :post, params: params }

    let!(:follower) { create :user }
    let(:params) { { id: follower.id } }

    it 'user starts follow another user' do
      expect { subject }.to change(Follow, :count).by(1)
    end

    it 'redirects back' do
      is_expected.to redirect_to root_path
    end
  end

  #   describe '#destroy' do
  #     subject { process :destroy, method: :delete, params: params }

  #     let!(:follower) { create :user }
  #     let!(:follow) { create :follow, follower_id: follower.id, followed_user: user.id }
  #     let(:params) { { id: follower.id } }

  #     it 'users breaks with following another user' do
  #       expect { subject }.to change(Follow, :count).by(-1)
  #     end

  #     it 'redirects back' do
  #       is_expected.to redirect_to root_path
  #     end
  #   end

  #   describe '#destroy' do
  #     subject { process :destroy, method: :delete, params: params }

  #     let(:followee) { create :user }
  #     let!(:follow) { create :follow, follower: user, followee: followee }
  #     let(:params) do
  #       { id: follow }
  #     end

  #     it 'users breaks with following another user' do
  #       expect(subject).to change(Follow, :count).by(-1)
  #     end

  #     it 'redirects back' do
  #       is_expected.to redirect_to root_path
  #     end
  #   end

  describe '#follows' do
    subject { process :follows, method: :get, params: params }

    let(:params) { { id: user.id } }

    it 'renders follows template' do
      subject
      expect(response).to render_template :follows
    end
  end

  describe '#followers' do
    subject { process :followers, method: :get, params: params }

    let(:params) { { id: user.id } }

    it 'renders follows template' do
      subject
      expect(response).to render_template :followers
    end
  end
end
