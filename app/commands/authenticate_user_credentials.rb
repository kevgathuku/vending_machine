require 'dry/monads'

class AuthenticateUserCredentials
  include Dry::Monads[:result, :do]

  def call(username:, password:)
    @username = username
    @password = password

    existing_user = yield fetch_user
    user = yield validate_password(user: existing_user)
    token = JsonWebToken.encode(user_id: user.id)

    Success(token)
  end

  private

  attr_reader :username, :password

  def fetch_user
    user = User.find_by(username: username)

    if user
      Success(user)
    else
      Failure(:authentication_failure, 'User not found')
    end
  end

  def validate_password(user:)
    result = user.authenticate(password)
    if result
      Success(result)
    else
      Failure(:authentication_failure, 'Invalid credentials')
    end
  end
end
