require 'rails_helper'

RSpec.describe Note, type: :model do
  subject(:note) { build(:note) }

  describe 'factory' do
    it 'can create a valid note with real attributes' do
      expect(note).to be_valid
    end
  end

  describe 'user association' do
    it { is_expected.to belong_to(:user) }
  end

  %i[title content note_type].each do |value|
    it { is_expected.to validate_presence_of(value) }
  end

  describe 'enums' do
    it 'defines note_type enum correctly' do
      expect(described_class.note_types).to include('review' => 0, 'critique' => 1)
    end
  end

  describe '#word_count' do
    it 'counts words in content' do
      note.content = 'this is a test'
      expect(note.word_count).to eq(4)
    end
  end

  describe '#over' do
    it 'returns true if word_count > limit' do
      note.content = 'word ' * 10
      expect(note.over?(5)).to be true
    end

    it 'returns false if word_count <= limit' do
      note.content = 'word ' * 2
      expect(note.over?(5)).to be false
    end
  end

  describe '#limit_content_review' do
    let(:user) { create(:user) }
    let(:note) { build(:note, user: user, note_type: note_type) }

    before do
      utility = double('Utility', limit_content_review_length: 100)
      allow(note).to receive(:utility).and_return(utility)
    end

    context 'when note_type is critique' do
      let(:note_type) { :critique }

      it 'does NOT validate content length' do
        allow(note).to receive(:word_count).and_return(200)
        expect(note).to be_valid
      end
    end

    context 'when note_type is review' do
      let(:note_type) { :review }

      it 'is valid if word_count within limit' do
        allow(note).to receive(:word_count).and_return(50)
        expect(note).to be_valid
      end

      it 'is invalid if word_count exceeds limit' do
        allow(note).to receive(:word_count).and_return(150)
        expect(note).not_to be_valid
        expect(note.errors[:content]).to include(
          I18n.t('note_limit_content_length', limit: 100)
        )
      end
    end
  end

  describe '#content_length' do
    let(:user) { create(:user) }
    let(:note) { build(:note, user: user) }

    before do
      utility = double('Utility',
                       limit_min_length: 50,
                       limit_medium_length: 100)
      allow(note).to receive(:utility).and_return(utility)
    end

    it 'returns min when word_count <= min' do
      allow(note).to receive(:word_count).and_return(30)
      expect(note.content_length).to eq(I18n.t('note_min_length'))
    end

    it 'returns medium when word_count between min and medium' do
      allow(note).to receive(:word_count).and_return(75)
      expect(note.content_length).to eq(I18n.t('note_medium_length'))
    end

    it 'returns long when word_count > medium' do
      allow(note).to receive(:word_count).and_return(150)
      expect(note.content_length).to eq(I18n.t('note_long_length'))
    end
  end

  describe '#utility' do
    it 'delegates to user' do
      user = create(:user)
      note = build(:note, user: user)
      expect(note.utility).to eq(user.utility)
    end
  end
end
