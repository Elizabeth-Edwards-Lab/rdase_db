# Perform a 'smart round', where the following rounding results apply (here assuming # of digits is 2)
# 2.00 -> 2
# 2.01 -> 2.01
# 0.011 -> 0.011
# 0.111 -> 0.11
# 0.001 -> 0.001
# 0.0012 -> 0.0012
# 0.00121 -> 0.0012
# This will overwrite (by adding function) the Float class
class Float
  def smart_round_to_s(digits=2)
    f = if digits <= 0
      self.to_f.round
    elsif self.to_f < 1
      sprintf("%.#{digits - 1}e", self).to_f
    else
      sprintf( "%.#{digits}f", self ).to_f
    end
    i = f.to_i
    (i == f ? i : f).to_s
  end
end