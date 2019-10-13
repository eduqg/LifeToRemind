module ApplicationHelper
  def select_color(progress)
    if progress < 30
      bar_color = @chartColors[0]
    elsif progress > 31 and progress < 60
      bar_color = @chartColors[1]
    else
      bar_color = @chartColors[2]
    end
    bar_color
  end

  def devise_controller?
    %w[registrations sessions].include?(controller_name)
  end
end
