require_relative 'conjured_item'
require_relative 'constant'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      update_item_quality(item)
    end
  end

  private

  def update_item_quality(item)
    case item.name
    when Constant::CONJURED_ITEM
      ConjuredItem.new(item).update_quality
    else
      update_other_item(item)
    end
  end

  def update_other_item(item)
    if item.sell_in > 0
      if item.name != Constant::AGED_BRIE_ITEM and item.name != Constant::BACKSTAGE_CONCERT_ITEM
        if item.quality > 0
          if item.name != Constant::SULFURAS_ITEM
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == Constant::BACKSTAGE_CONCERT_ITEM
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
    else
      if item.name != Constant::AGED_BRIE_ITEM
        if item.name != Constant::BACKSTAGE_CONCERT_ITEM
          if item.quality > 0
            if item.name != Constant::SULFURAS_ITEM
              item.quality = [item.quality - 2, 0].max
            end
          end
        else
          item.quality = item.quality - item.quality
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
        end
      end
    end

    if item.name != Constant::SULFURAS_ITEM
      item.sell_in = item.sell_in - 1
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end


