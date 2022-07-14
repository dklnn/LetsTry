require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before { sign_in user }

  describe '#show' do
    subject { process :show, method: :get, params: params }

    let!(:user) { create :user }
    let(:post) { create :post, user: user }
    let(:params) { { id: user.id } }

    it 'renders show template' do
      subject
      expect(response).to render_template :show
    end

    it 'assign @user' do
      subject
      expect(assigns(:user)).to eq user
    end

    context 'when user trying to see non-existent account' do
      let(:params) { { id: user.id + 1 } }

      it 'redirects back' do
        expect { subject }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
