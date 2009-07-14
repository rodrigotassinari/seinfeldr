# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def reference_link_to(text, url, thickbox_params="KeepThis=true&TB_iframe=true&height=550&width=900")
    return text if url.blank?
    thickbox_url = if url.include?('?')
      "&#{thickbox_params}"
    else
      "?#{thickbox_params}"
    end
    link_to(
      text,
      "#{url}#{thickbox_url}",
      :class => 'thickbox'
    )
  end
  
  # Example:
  #
  #   >> flash[:notice] = "Yada yada yada"
  #   >> display_flashes
  #   => "<div class=\"flash\ id=\"flash_notice\"><p>Yada yada yada</p></div>"
  #
  def display_flashes
    return nil if flash.empty?
    html = '<div class="grid_16">'
    flash.each do |key, message|
      flash_message = content_tag(:p, message)
      close_link = content_tag(
        :span,
        link_to_function('fechar', "$('#flash_#{key}').hide()"),
        :class => 'close'
      )
      html << content_tag(:div, close_link + flash_message, :class => 'flash', :id => "flash_#{key}")
    end
    html << '</div>'
    html
  end
  
  def ordinal(int, gender='º')
    if I18n.locale.to_sym == :en
      int.ordinalize
    else
      "#{int}#{gender}"
    end
  end
  
  def will_paginate_t(collection)
    will_paginate(collection, :prev_label => t(:prev_label), :next_label => t(:next_label))
  end
  
  def google_analytics_javascript(analytics_id)
    return unless Rails.env.production?
    <<-eos
      <script type="text/javascript">
      var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
      document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
      </script>
      <script type="text/javascript">
      try {
      var pageTracker = _gat._getTracker("#{analytics_id}");
      pageTracker._trackPageview();
      } catch(err) {}</script>
    eos
  end

end
