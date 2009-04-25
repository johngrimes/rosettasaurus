class String
  def hex_values
    hexs = []
    for i in 0..(self.length - 1)
      hexs << self[i].to_s(16)
    end
    hexs
  end
end