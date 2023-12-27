require 'rspec'
require_relative 'gilded_rose'
require_relative 'conjured_item'

describe ConjuredItem do
  describe '#update_quality' do
    context 'with Conjured items' do
      it 'decreases quality by 2 before sell_in date' do
        item = Item.new('Conjured', 5, 10)
        ConjuredItem.new(item).update_quality
        expect(item.quality).to eq(8)
      end

      it 'never sets quality to a negative value' do
        item = Item.new('Conjured', 0, 1)
        ConjuredItem.new(item).update_quality
        expect(item.quality).to eq(0)
      end
    end
  end
end
