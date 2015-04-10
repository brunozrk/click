Rails.env.on(:any) do |config|
  config.time_zone = 'Brasilia'

  config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
  config.i18n.available_locales = [:en, :"pt-BR"]
  config.i18n.default_locale = :"pt-BR"

  config.encoding = 'utf-8'
end
