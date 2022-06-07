# frozen_string_literal: true

class String
  def bg_black
    "\e[47m#{self}\e[0m"
  end

  def bg_white
    "\e[100m#{self}\e[0m"
  end
end
