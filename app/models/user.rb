class User < ActiveRecord::Base

	has_secure_password

	has_one :profile

	accepts_nested_attributes_for :profile # ', allow_destroy: true' to allow the user to delete their profile. Then, set a hidden field inside the form like '= f.input :_destroy, as: :hidden'.

	validates :email, presence: true, uniqueness: true, email_format: true

	delegate :full_name, to: :profile # add ', prefix: true' to direct search among similarly named paths. Then prefix the call with the relevant specifier.

end
