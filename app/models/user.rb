class User < ActiveRecord::Base

	has_secure_password

	has_one :profile
	has_many :campaigns
  has_one :api_key

	accepts_nested_attributes_for :profile # ', allow_destroy: true' to allow the user to delete their profile. Then, set a hidden field inside the form like '= f.input :_destroy, as: :hidden'.

	validates :email, presence: true, uniqueness: true, email_format: true

	delegate :full_name, :address, to: :profile # add ', prefix: true' to direct search among similarly named paths. Then prefix the call with the relevant specifier.

  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = ApiKey.new
  end

end
