# frozen_string_literal: true

# class BooksController
class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!

  protect_from_forgery with: :exception, prepend: true
end
