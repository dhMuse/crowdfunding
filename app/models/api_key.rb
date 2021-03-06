class ApiKey < ActiveRecord::Base
  belongs_to :user
  before_create :generate_unique_access_token

  private

  def generate_unique_access_token
    begin
      self.access_token = SecureRandom.hex  
    end while self.class.exists?(access_token: access_token)
    # next line is the same as above line
    # end while ApiKey.exists?(access_token: access_token)
  end

end
