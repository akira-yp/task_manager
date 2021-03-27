module ApplicationHelper
  protect_from_forgery with: :exeption
  include SessoionsHelper
end
