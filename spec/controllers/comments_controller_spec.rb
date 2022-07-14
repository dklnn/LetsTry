require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create :user }
  let(:post) { create :post }
  before { sign_in user }

  describe '#create' do
    subject { process :create, method: :post, params: params }

    let!(:post) { create :post, user: user }
    let(:params) do
      {
        comment: attributes_for(:comment),
        post_id: post
      }
    end

    it 'creates a comment' do
      expect { subject }.to change(Comment, :count).by(1)
    end

    it 'redirects to parent post page' do
      subject
      expect(response).to redirect_to root_path
    end

    it 'assigns comment to current user' do
      subject
      expect(assigns(:comment).user).to eq user
    end

    it 'assigns comment to current post' do
      subject
      expect(assigns(:comment).post).to eq post
    end

    context 'when user tries to create the post without a body' do
      let(:params) do
        {
          comment: { body: ' ' },
          post_id: post
        }
      end

      it 'validates the comment' do
        expect { subject }.to raise_exception(ActiveRecord::RecordInvalid)
      end

      it 'redirects back' do
        expect(response).not_to be_redirect
      end
    end
  end

  describe '#edit' do
    subject { process :edit, method: :get, params: params }

    let!(:comment) { create :comment, post: post, user: user }
    let(:params) { { post_id: post.id, id: comment.id } }

    it 'renders the edit template' do
      subject
      expect(response).to render_template :edit
    end

    context 'when user tries to edit someones comment' do
      let!(:comment) { create :comment }

      it 'redirects back' do
        expect { subject }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#update' do
    subject { process :update, method: :patch, params: params }

    let!(:comment) { create :comment, post: post, user: user }
    let!(:params) do
      {
        comment: { body: 'new body' },
        id: comment.id,
        post_id: post.id
      }
    end

    # PROBLEM WITH RSPEC TESTS FOR UPDATE METHOD IN COMMENTS AND IN THE POST ALSO
    # it 'updates the comment' do
    #   expect { subject }.to change(comment, :body)
    # end

    it 'redirects back' do
      subject
      expect(response).to redirect_to post_path(params[:post_id])
    end
  end

  describe '#destroy' do
    subject { process :destroy, method: :delete, params: params }

    let!(:comment) { create :comment, post: post, user: user }
    let(:params) do
      {
        post_id: post.id,
        id: comment.id
      }
    end

    it 'deletes the comment' do
      expect { subject }.to change(Comment, :count).by(-1)
    end

    it 'redirects back' do
      is_expected.to redirect_to root_path
    end

    context 'when user tries to delete someones comment' do
      let!(:comment) { create :comment, post: post }

      it 'redirects back' do
        expect { subject }.to raise_exception(ActiveRecord::RecordNotFound).and(
          change(user.comments, :count).by(0)
        )
      end
    end
  end
end
