require 'rails_helper'

RSpec.describe SouthUtility, type: :model do
  subject(:utility) { create(:south_utility) }

  describe 'factory' do
    it 'has a valid factory' do
      expect(utility).to be_valid
    end
  end

  describe '#limit_content_review_length' do
    it 'returns the correct minimum length for South' do
      expect(utility.limit_content_review_length).to eq(60)
    end
  end

  describe '#limit_min_length' do
    it 'returns the correct minimum length for South' do
      expect(utility.limit_min_length).to eq(60)
    end
  end

  describe '#limit_medium_length' do
    it 'returns the correct medium length for South' do
      expect(utility.limit_medium_length).to eq(120)
    end
  end
end
