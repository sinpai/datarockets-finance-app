class Categories::Amount
  def initialize(category)
    @category = category
  end

  def calculate
    @category.self_and_descendents.map(&:amount).flatten.reduce(0, :+)
  end

  def self_and_descendents
    [self] + descendents
  end

  def descendents
    @category.sub_categories.map do |sub_category|
      [sub_category] + sub_category.sub_categories + Categories::Amount.new(sub_category).descendents
    end.flatten.uniq
  end
end
