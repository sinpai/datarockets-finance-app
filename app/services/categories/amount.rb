class Categories::Amount
  def initialize(category)
    @category = category.is_a?(CategoryDecorator) ? category.object : category
  end

  def calculate
    self_and_descendents(@category).map(&:amount).flatten.reduce(0, :+)
  end

  def self_and_descendents(category = @category)
    [category] + descendents(category)
  end

  def descendents(category = @category)
    category.sub_categories.map do |sub_category|
      [sub_category] + sub_category.sub_categories + Categories::Amount.new(sub_category).descendents
    end.flatten.uniq
  end
end
