# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :set_locale
  
  protected
  
    def set_locale
      #logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
      locale = params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
      locale = I18n.default_locale unless I18n.available_locales.include?(locale.to_sym)
      I18n.locale = locale
      #logger.debug "* Locale set to '#{I18n.locale}'"
    end
    
    def default_url_options(options={})
      #logger.debug "default_url_options is passed options: #{options.inspect}\n"
      { :locale => I18n.locale }
    end
    
    def extract_locale_from_accept_language_header
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end 
    
end

