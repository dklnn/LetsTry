require 'rails_helper'

RSpec.describe Like, type: :model do
  it { is_expected.to validate_presence_of(:likeable_id) }
  it { is_expected.to validate_presence_of(:likeable_type) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:likeable) }
end
