class Submission < ApplicationRecord
  belongs_to :issue
  belongs_to :group
end
