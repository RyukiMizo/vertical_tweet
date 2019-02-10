class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  ##ここでincludeすることで、SessionHelper moduleが全てのコントローラーに適応される。
end
