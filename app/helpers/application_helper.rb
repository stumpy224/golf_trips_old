module ApplicationHelper
  EMAIL_TEMPLATE_FOR_TEAM_RESULTS = "team_results_and_next_day_team"

  def email_regex
    /([^\s;*'"():!]{1,})([@]{1,1})([^\s;*'"():!]{1,})([.]{1,1})([\w]{2,})/
  end

  def full_title(page_title)
    base_title = 'Golf Hacker Club'
    page_title.empty? ? base_title : base_title + " | " + page_title
  end

  def get_points(par, strokes)
    if !strokes.nil? && strokes > 0
      result = strokes - par

      if result == -3
        # albatross
        return 5
      elsif result == -2
        # eagle
        return 4
      elsif result == -1
        # birdie
        return 3
      elsif result == 0
        # par
        return 2
      elsif result == 1
        # bogey
        return 1
      else
        # double-bogey+
        return 0
      end
    end

    return 0
  end
end
