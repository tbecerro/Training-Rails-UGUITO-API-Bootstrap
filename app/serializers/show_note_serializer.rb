class ShowNoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :note_type,  :word_count, :created_at, :content, :content_length
  belongs_to :user
  delegate :content_length, to: :object

  delegate :word_count, to: :object
end
