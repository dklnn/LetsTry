require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(3).is_at_most(2000) }
  it { is_expected.to validate_length_of(:title).is_at_most(125) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_one_attached(:image) }
end
