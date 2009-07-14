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

end
