require_relative 'base'

class OverSixtyPound < Base

  def execute total

     return big_decimal(total * 0.90 ).to_f if total > 60

     total.to_f
  end
end