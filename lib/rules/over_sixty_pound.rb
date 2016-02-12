require_relative 'base'

class OverSixtyPound < Base

  def execute total

     if total > 60
       @applied = true
       return big_decimal(total * 0.90 )
     end

     total.to_f
  end
end