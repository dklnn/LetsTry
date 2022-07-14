require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(127) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_many(:posts).dependent(:destroy) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:followed_users).class_name('Follow') }
  it { is_expected.to have_many(:followees).through(:followed_users) }
  it { is_expected.to have_many(:following_users).class_name('Follow') }
  it { is_expected.to have_many(:followers).through(:following_users) }
  it { is_expected.to have_one_attached(:avatar) }
end
