class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def hello
    render html: 'hello world. How are you?'
  end
end
