require 'bigdecimal'

class Base

  attr_accessor :items, :applied

  AMOUNT_SIGNIFICANT_FIGURES = 7

  def total
    @items.collect(&:price).reduce(0, :+)
  end

  def big_decimal value
    BigDecimal(value, AMOUNT_SIGNIFICANT_FIGURES).round 2
  end
end