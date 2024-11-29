module ProfilesHelper
  def avatar_url_for(user)
    if user.avatar.present?
      user.avatar
    else
      gravatar_for(user)
    end
  end

  private

  def gravatar_for(user, options = { size: 100 })
    # docs:
    # https://docs.gravatar.com/api/avatars/ruby/
    # https://docs.gravatar.com/api/avatars/images/

    email_address = user.email.downcase

    # Create the SHA256 hash
    gravatar_id = Digest::SHA256.hexdigest(email_address)

    # Set default URL and size parameters

    # default image MUST be publicly accessible, so cannot be accessed from local machine
    default = if Rails.env.development?
      "robohash"
    else
      asset_url("default_avatar.png")
    end

    size = options[:size]

    # Compile the full URL with URI encoding for the parameters
    params = URI.encode_www_form("d" => default, "s" => size)

    image_src = "https://www.gravatar.com/avatar/#{gravatar_id}?#{params}"

    # This 'image_src' can now be used in an <img> tag or wherever needed
    image_src
  end
end
