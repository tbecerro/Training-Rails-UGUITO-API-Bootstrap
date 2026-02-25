class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :note_type
  belongs_to :user
end
