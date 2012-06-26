Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '	125498407590315', '602d7e795c41a95cf1b357a91ac3672e', :scope => 'email,offline_access,read_stream,share_item', :display => 'popup'
end