# frozen_string_literal: true

# class BooksController
class PublicController < ApplicationController
  skip_before_action :authenticate_user!

  def home; end
end
