require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create :user }
  before { sign_in user }

  describe '#index' do
    subject { process :index }

    let(:posts) { create_list(:post, 3) }

    it 'renders the index template' do
      is_expected.to render_template :show
    end

    it 'assign @posts' do
      subject
      expected_posts = posts.sort_by(&:updated_at).reverse
      expect(assigns(:posts)).to eq expected_posts
    end

    context 'when user in not signed in' do
      before { sign_out user }
      it 'redirects to the sign in page' do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#show' do
    subject { process :show, method: :get, params: params }

    let!(:post) { create :post, user: user }
    let(:params) { { id: post.id } }

    it 'renders the show template' do
      subject
      expect(response).to render_template :show
    end

    it 'assign @post' do
      subject
      expect(assigns(:post)).to eq post
    end

    context 'user tries to show non-existent post' do
      let(:params) { { id: post.id + 1 } }

      it 'redirects back' do
        expect { subject }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#new' do
    subject { process :new }

    it 'assigns @post' do
      subject
      expect(assigns(:post)).to be_a_new Post
    end

    it 'renders the new template' do
      subject
      expect(response).to render_template :new
    end
  end

  describe '#create' do
    subject { process :create, method: :post, params: params }

    let(:params) { { post: attributes_for(:post, user: create(:user)) } }

    it 'creates a post' do
      expect { subject }.to change(Post, :count).by(1)
    end

    it 'redirects to post page' do
      subject
      expect(response).to redirect_to post_path(Post.last)
    end

    it 'assigns post to current user' do
      subject
      expect(assigns(:post).user).to eq user
    end

    context 'when user tries to create the post without an image' do
      let(:params) { { post: { body: '', title: '', image_attached: false } } }

      it 'validates the post' do
        expect { subject }.to raise_exception(ActiveRecord::RecordInvalid)
      end

      it 'redirects back' do
        expect(response).not_to be_redirect
      end
    end
  end

  describe '#edit' do
    subject { process :edit, method: :get, params: params }

    let!(:post) { create :post, user: user }
    let(:params) { { id: post.id } }

    it 'renders the edit template' do
      subject
      expect(response).to render_template :edit
    end

    context 'when user tries to edit someones post' do
      let!(:post) { create :post }

      it 'redirects back' do
        expect { subject }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  # describe '#update' do
  #   subject { process :update, method: :patch, params: params }

  #   let!(:post) { create :post, user: user }
  #   let!(:post1) { post1: post }
  #   let(:params) { { title: 'new title', body: 'new body' } }

  #   it 'updates the post' do
  #     expect { subject}.not_to eq post1
  #   end
  # end

  describe '#destroy' do
    subject { process :destroy, method: :delete, params: params }

    let!(:post) { create :post, user: user }
    let(:params) { { id: post.id } }

    it 'deletes the post' do
      expect { subject }.to change(Post, :count).by(-1)
    end

    it 'redirects back' do
      subject
      expect(response).to redirect_to user_path(user)
    end

    context 'when user treis to remove someones post' do
      let!(:post) { create :post }

      it 'redirects back' do
        expect { subject }.to raise_exception(ActiveRecord::RecordNotFound).and(
          change(user.posts, :count).by(0)
        )
      end
    end
  end
end
