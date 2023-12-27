class ConjuredItem
  def initialize(item)
    @item = item
  end

  def update_quality
    @item.quality = [(@item.quality - 2), 0].max
    @item.sell_in -= 1
  end
end