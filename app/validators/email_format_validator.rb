class EmailFormatValidator < ActiveModel::EachValidator

	EMAIL_REGEX = /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

	def validate_each(object, attribute, value)
		unless value =~ EMAIL_REGEX
			object.errors[attribute] << (options[:message] || "is not formatted correctly")
		end
	end

end