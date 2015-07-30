module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Railsbricks2215"
    end
  end
end
