class RewardLevel < ActiveRecord::Base
  belongs_to :campaign

  validates_presence_of :title, :details, :amount

  delegate :title, to: :campaign, prefix: true
end
