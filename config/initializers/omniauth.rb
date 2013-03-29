Rails.configuration.middleware.use OmniAuth::Builder do
  provider :google_oauth2, APP_CONFIG["GOOGLE_KEY"], APP_CONFIG["GOOGLE_SECRET"],
    {
      :scope => "userinfo.email,userinfo.profile,plus.me,https://picasaweb.google.com/data/",
      :approval_prompt => "force", access_type: 'offline'
    }
end
