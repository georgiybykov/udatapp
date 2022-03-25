# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user

  validates :title, :body, presence: true

  scope :not_private, -> { where(private: false) }
end
