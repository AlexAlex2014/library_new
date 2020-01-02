# frozen_string_literal: true

# module CategoriesHelper
module CategoriesHelper
  def show_svg(path)
    File.open("app/assets/images/categories/#{path}", 'rb') do |file|
      raw file.read
    end
  end
end
