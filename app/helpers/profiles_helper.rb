module ProfilesHelper
  def avatar_url_for(user)
    return gravatar_for(user) if user.nil? || !user.avatar.attached?

    user.avatar
  end

  private

  def gravatar_for(user, options = { size: 100 })
    # docs:
    # https://docs.gravatar.com/api/avatars/ruby/
    # https://docs.gravatar.com/api/avatars/images/

    # Create the SHA256 hash
    gravatar_id = if user&.email.present?
      Digest::SHA256.hexdigest(user.email.downcase)
    else
      # nothing - fall back to the default image.
    end

    # Set default URL and size parameters
    default = "robohash"
    size = options[:size]

    # Compile the full URL with URI encoding for the parameters
    params = URI.encode_www_form("d" => default, "s" => size)

    image_src = "https://www.gravatar.com/avatar/#{gravatar_id}?#{params}"

    # This 'image_src' can now be used in an <img> tag or wherever needed
    image_src
  end
end
