class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  around_action :switch_locale

  private

  # Saved choice from the EN/ID toggle wins, then the browser language, then English.
  def switch_locale(&action)
    I18n.with_locale(locale_from(cookies[:locale]) || browser_locale || I18n.default_locale, &action)
  end

  # shortcut: takes the first supported language in header order and ignores q-weights; fine for two locales.
  def browser_locale
    request.headers["Accept-Language"].to_s.scan(/\b([a-z]{2})(?:-[A-Za-z]{2})?\b/).flatten.map { |code| locale_from(code) }.compact.first
  end

  def locale_from(value)
    value.to_s.to_sym.presence_in(I18n.available_locales)
  end
end
