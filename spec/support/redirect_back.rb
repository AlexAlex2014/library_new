# frozen_string_literal: true

# module RedirectBack
module RedirectBack
  def from(url)
    request.env['HTTP_REFERER'] = url
  end
end
