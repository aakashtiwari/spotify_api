class AuthenticateUser 
	prepend SimpleCommand

	def initialize(username, password)
		@username = username
		@password = password
	end

	def call
		token = JsonWebToken.encode(user_id: user.id) if user
		user_data = User.where(username: username).select(:id, :username, :first_name, :last_name)[0] if user
		body = {  user: user_data,
							token: token } if user
	end

	private 

	attr_accessor :username, :password

	def user
		user = User.find_by_username(username)
		return user if user && user.authenticate(password)
		errors.add :user_authentication, 'invalid credentials'
		nil
	end
end
