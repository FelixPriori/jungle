require 'rails_helper'

# It must be created with a password and password_confirmation fields
  # These need to match so you should have an example for where they are not the same
  # These are required when creating the model so you should also have an example for this
# Emails must be unique (not case sensitive; for example, TEST@TEST.com should not be allowed if test@test.COM is in the database)
# Email, first name, and last name should also be required

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
        @user1 = User.new(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password')
        @user2 = User.new(first_name: 'bob', last_name: 'bobby', email: 'bob@example.com', password: 'password')
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
  end
end