# == Schema Information
#
# Table name: notes
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  content    :string           not null
#  note_type  :integer          not null
#  user_id    :bigint(8)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Note < ApplicationRecord
  belongs_to :user
  enum note_type: { review: 0, critique: 1 }
  validates :title, :content, :note_type, presence: true
  validate :limit_content_review

  def limit_content_review
    return unless note_type == 'review' && over?(utility.limit_content_review_length)

    errors.add(:content,
               I18n.t('note_limit_content_length',
                      limit: utility.limit_content_review_length))
  end

  def content_length
    return I18n.t('note_min_length') if word_count.between?(0, utility.limit_min_length)
    return I18n.t('note_medium_length') if word_count.between?(utility.limit_min_length,
                                                               utility.limit_medium_length)
     I18n.t('note_long_length') 
  end

  def word_count
    content.split.size
  end

  def over?(limit)
    word_count > limit
  end

  delegate :utility, to: :user
end
