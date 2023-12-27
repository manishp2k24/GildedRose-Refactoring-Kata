require File.join(File.dirname(__FILE__), 'gilded_rose')
require_relative 'constant'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context 'with normal items' do
      it 'decreases quality by 1 before sell_in date' do
        items = [Item.new('Normal Item', 5, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(9)
      end

      it 'decreases quality by 2 after sell_in date' do
        items = [Item.new('Normal Item', -1, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(8)
      end

      it 'never sets quality to a negative value' do
        items = [Item.new('Normal Item', 0, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(0)
      end
    end

    context 'with Aged Brie' do
      it 'increases quality by 1 before sell_in date' do
        items = [Item.new(Constant::AGED_BRIE_ITEM, 5, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(11)
      end

      it 'never sets quality above 50' do
        items = [Item.new(Constant::AGED_BRIE_ITEM, 5, 50)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(50)
      end
    end

    context 'with Sulfuras' do
      it 'does not change quality or sell_in value' do
        items = [Item.new(Constant::SULFURAS_ITEM, 5, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(80)
        expect(items[0].sell_in).to eq(5)
      end
    end

    context 'with Backstage passes' do
      it 'increases quality by 2 when sell_in is 10 days or less' do
        items = [Item.new(Constant::BACKSTAGE_CONCERT_ITEM, 10, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(22)
      end

      it 'increases quality by 3 when sell_in is 5 days or less' do
        items = [Item.new(Constant::BACKSTAGE_CONCERT_ITEM, 5, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(23)
      end

      it 'sets quality to 0 after the concert' do
        items = [Item.new(Constant::BACKSTAGE_CONCERT_ITEM, 0, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(0)
      end
    end

    context 'with Conjured items' do
      it 'decreases quality by 2 before sell_in date' do
        items = [Item.new(Constant::CONJURED_ITEM, 5, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(8)
      end

      it 'never sets quality to a negative value' do
        items = [Item.new(Constant::CONJURED_ITEM, 0, 1)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(0)
      end
    end
  end

end
