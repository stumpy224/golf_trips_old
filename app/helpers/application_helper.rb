module ApplicationHelper
  def email_regex
    /([^\s;*'"():!]{1,})([@]{1,1})([^\s;*'"():!]{1,})([.]{1,1})([\w]{2,})/
  end

  def full_title(page_title)
    base_title = 'Golf Hacker Club'
    page_title.empty? ? base_title : base_title + " | " + page_title
  end
end
