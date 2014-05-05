class CampaignDecorator < Draper::Decorator
  delegate_all

  def title
  	object.title.upcase
  end

  def label_class
  	h.label_class(object.state)
  end

  def state
  	object.state.capitalize
  end

  def short_details
  	object.details.truncate(50)
  end

  def ajax_view_link
  	h.link_to "View", campaign, class: "btn btn-primary", remote: true, data: {toggle: "modal", target: "#campaign-view"}
  end

  def created_at
    object.created_at.strftime("%Y-%B-%d")
    h.formatted_date(object.created_at)
  end

  def gen_marker(marker)
    marker.lat object.latitude
    marker.lng object.longitude
    link = h.link_to object.title, object
    info = "#{link}<br>#{short_details}"
    marker.infowindow object.title
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
