class Acquaint < ActiveRecord::Base
  belongs_to :user
  belongs_to :issue

  validates_presence_of :user, :issue
  validates_uniqueness_of :user_id, scope: :issue_id
end
