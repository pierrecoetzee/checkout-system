class Checkout
  attr_reader :rules, :items

  def initialize rules: []
    @items = []
    @rules = rules
  end

  def scan item
    @items << item
  end

  def total
    return gross_total if rules.empty?

    rules.inject(new_totals = []) do |new_totals,r|
      new_totals << r.execute(@items) unless r.is_a?(OverSixtyPound)
    end

    new_price = new_totals.reduce(0, :+)

    return new_price unless over_sixty_rule_applies?

    over_sixty_rule.execute(new_price == 0 ? gross_total :  new_price)

  end

  private

  def gross_total
    @items.collect(&:price).reduce(0,:+)
  end

  def over_sixty_rule_applies?
    rules.collect(&:class).include?(OverSixtyPound)
  end

  def over_sixty_rule
    rules.find{|r| r.is_a?(OverSixtyPound)}
  end

end