# Add a new method for all strings to use.
class String

  # Capitalize every word
  def titleize
    self.split(' ').map {|w| w.capitalize}.join(" ")
  end

end
