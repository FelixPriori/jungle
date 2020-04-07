require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    context 'password do not match' do
      it 'should not save successfully' do
        @user = User.create(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password', password_confirmation: 'something else')
        @user.save
        expect(@user).to_not be_valid
      end
    end

    context 'with password, email, first_name, last_name' do
      it 'should save successfully' do
        @user = User.new(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password', password_confirmation: 'password')
        @user.save
        expect(@user).to be_valid
      end
    end

    context 'with duplicated email' do
      it 'should not save successfully' do
        @user1 = User.create!(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password', password_confirmation: 'password')
        @user2 = User.new(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password')
        @user2.save
        expect(@user2).to_not be_valid
      end
      it 'should not be case sensitive' do
        @user1 = User.create!(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password', password_confirmation: 'password')
        @user2 = User.new(first_name: 'bob', last_name: 'bobby', email: 'BOB@EXAMPLE.COM', password: 'password', password_confirmation: 'password')
        @user2.save
        expect(@user2).to_not be_valid
      end
    end

    context 'without an email' do
      it 'should not save successfully' do
        @user = User.new(first_name: 'bob', last_name: 'bobby', email: nil, password: 'password', password_confirmation: 'password')
        @user.save
        expect(@user).to_not be_valid
      end
    end

    context 'without a last_name' do
      it 'should not save successfully' do
        @user = User.new(first_name: 'bob', last_name: nil, email: 'bob@example.com', password: 'password', password_confirmation: 'password')
        @user.save
        expect(@user).to_not be_valid
      end
    end

    context 'without a first_name' do
      it 'should not save successfully' do
        @user = User.new(first_name: nil, last_name: 'bobby', email: 'bob@example.com', password: 'password', password_confirmation: 'password')
        @user.save
        expect(@user).to_not be_valid
      end
    end

    context 'without a password' do
      it 'should not save successfully' do
        @user = User.new(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: nil, password_confirmation: 'password')
        @user.save
        expect(@user).to_not be_valid
      end
    end

    context 'with a password of less than 6 characters' do
      it 'should not save successfully' do
        @user = User.new(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'pw', password_confirmation: 'password')
        expect(@user).to_not be_valid
      end
    end

  end
  describe '.authenticate_with_credentials' do

    context 'with a correct email and password' do
      it 'should return the user object' do
        @user = User.create!(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password', password_confirmation: 'password')
        user = User.authenticate_with_credentials('bob@example.com', 'password')
        expect(user).to eq(@user)
      end
    end

    context 'with an incorrect email' do
      it 'should return the user object' do
        user = User.authenticate_with_credentials('bobby@example.com', 'password')
        expect(user).to be nil
      end
    end

    context 'with an email that has whitespace' do
      context 'before' do
        it 'should log in successfully' do
          @user = User.create!(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password', password_confirmation: 'password')
          user = User.authenticate_with_credentials('   bob@example.com', 'password')
          expect(user).to eq(@user)
        end
      end
      
      context 'after' do        
        it 'should log in successfully' do
          @user = User.create!(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password', password_confirmation: 'password')
          user = User.authenticate_with_credentials('bob@example.com   ', 'password')
          expect(user).to eq(@user)
        end
      end
    end

    context 'with an email that has a different case than in the db' do
      it 'should log in successfully' do
        @user = User.create!(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password', password_confirmation: 'password')
        user = User.authenticate_with_credentials('BOB@EXAMPLE.COM', 'password')
        expect(user).to eq(@user)
      end
    end
  end
end