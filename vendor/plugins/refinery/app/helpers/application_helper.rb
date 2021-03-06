# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def add_meta_tags
    unless @page.meta_keywords.blank?
      content_for :head, "<meta name=\"keywords\" content=\"#{@page.meta_keywords}\" />"
    end
    
    unless @page.meta_description.blank?
      content_for :head, "<meta name=\"description\" content=\"#{@page.meta_description}\" />"
    end
  end
  
  def add_page_title
		content_for :title, 
		if @page.browser_title.blank?
    	@page.path
    else
    	@page.browser_title
    end
  end
  
  def setup
    add_meta_tags
    add_page_title
  end
  
  def page_title
    case @page.custom_title_type
      when "none"
        @page.title
      when "text"
        @page.custom_title
      when "image"
        image_tag Image.find(@page.custom_title_image).public_filename rescue @page.title
    end
  end
  
  def descendant_page_selected?(page)
		not page.descendants.reject {|descendant| not selected_page?(descendant) }.empty?
  end
  
  def selected_page?(page)
    selected = current_page?(page) or (request.path =~ Regexp.new(page.menu_match) unless page.menu_match.blank?) or (request.path == page.link_url)
  end
  
end