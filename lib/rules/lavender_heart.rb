require_relative 'base'

class LavenderHeart < Base

  LAVENDER_HEART_SKU = 001

  def initialize
    @items = []
    @applied = false
  end

  def execute items
    @items = items
    return 0 unless can_apply_rule?

    @applied = true
    new_price
  end

  private

  def new_price
    ((8.50) * all_lavender_hearts.count) + non_lavender_hearts
  end

  def can_apply_rule?
    all_lavender_hearts.count > 1
  end

  def all_lavender_hearts
    @items.select{|i| i.sku == LAVENDER_HEART_SKU }
  end

  def non_lavender_hearts
    other = @items.select{|i| i.sku != LAVENDER_HEART_SKU }
    other.any? ? other.collect(&:price).reduce(:+) : 0
  end
end