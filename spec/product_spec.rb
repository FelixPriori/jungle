require 'rails_helper'

# validates :name, presence: true
# validates :price, presence: true
# validates :quantity, presence: true
# validates :category, presence: true

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context 'given a name, price, quantity, category' do
      it 'should save successfully' do
        @category = Category.new(name: 'Furniture')
        @product = Product.new(name: "Table", price: 80, quantity: 5, category: @category)
        expect(@product).to be_valid
      end
    end
    context 'without a name' do
      it 'should not save succesfully' do
        @category = Category.new(name: 'Furniture')
        @product = Product.new(name: nil, price: 80, quantity: 5, category: @category)
        expect(@product).to_not be_valid
      end
    end
    context 'without a price' do
      it 'should not save succesfully' do
        @category = Category.new(name: 'Furniture')
        @product = Product.new(name: "Table", price: nil, quantity: 5, category: @category)
        expect(@product).to_not be_valid
      end
    end
    context 'without a quantity' do
      it 'should not save succesfully' do
        @category = Category.new(name: 'Furniture')
        @product = Product.new(name: "Table", price: 80, quantity: nil, category: @category)
        expect(@product).to_not be_valid
      end
    end
    context 'without a category' do
      it 'should not save succesfully' do
        @product = Product.new(name: "Table", price: 80, quantity: 5, category: nil)
        expect(@product).to_not be_valid
      end
    end
  end
end
