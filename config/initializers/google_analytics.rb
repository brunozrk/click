Rails.env.on(:production) do
  GA.tracker = Rails.application.secrets.ga_tracker
end
