require_relative 'base'

class OverSixtyPound < Base

  def execute total

     if total > 60
       @applied = true
       return big_decimal(total * 0.90 ).to_f
     end

     total.to_f
  end
end