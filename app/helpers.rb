module AppHelpers
  def validate_password(password)
    password.length > 6
  end
end
