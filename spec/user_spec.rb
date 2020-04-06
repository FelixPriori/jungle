require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context 'with password, email, first_name, last_name' do
      it 'should save successfully' do
        @user = User.new(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password')
        expect(@user).to be_valid
      end
    end
    context 'with duplicated email' do
      it 'should not save successfully' do
        @user1 = User.create(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password')
        @user2 = User.new(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password')
        expect(@user2).to_not be_valid
      end
      it 'should not be case sensitive' do
        @user1 = User.create(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password')
        @user2 = User.new(first_name: 'bob', last_name: 'bobby', email: 'BOB@EXAMPLE.COM', password: 'password')
        expect(@user2).to_not be_valid
      end
    end
    context 'without an email' do
      it 'should not save successfully' do
        @user = User.new(first_name: 'bob', last_name: 'bobby', email: nil, password: 'password')
        expect(@user).to_not be_valid
      end
    end
    context 'without a last_name' do
      it 'should not save successfully' do
        @user = User.new(first_name: 'bob', last_name: nil, email: 'bob@example.com', password: 'password')
        expect(@user).to_not be_valid
      end
    end
    context 'without a first_name' do
      it 'should not save successfully' do
        @user = User.new(first_name: nil, last_name: 'bobby', email: 'bob@example.com', password: 'password')
        expect(@user).to_not be_valid
      end
    end
    context 'without a password' do
      it 'should not save successfully' do
        @user = User.new(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: nil)
        expect(@user).to_not be_valid
      end
    end
    context 'with a password of less than 6 characters' do
      it 'should not save successfully' do
        @user = User.new(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'pw')
        expect(@user).to_not be_valid
      end
    end
  end
end