require 'spec_helper'

describe User do
	before { @user = User.new(name: "Example User", email: "euser@example.com", password: "foobar", password_confirmation: "foobar") }
	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }

	it { should be_valid }
	
	describe "name not present" do
		before  { @user.name = " " }
		it { should_not be_valid }
	end
	describe "name too long" do
		before  { @user.name = "a" * 33 }
		it { should_not be_valid }
	end
	describe "name is already taken" do
		before do
			user_with_same_name = @user.dup
			user_with_same_name.name = @user.name.upcase
			user_with_same_name.save
		end
		it { should_not be_valid }
	end
	
	describe "password too short" do
		before { @user.password = @user.password = "a" * 3 }
		it { should be_invalid }
	end
	describe "authenticate method that returns" do
		before { @user.save }
		let(:found_user) { User.find_by(email: @user.email) }
		
		describe "valid password" do
			it { should eq found_user.authenticate(@user.password) }
		end
		
		describe "invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }
			
			it { should_not eq user_for_invalid_password }
			specify { expect(user_for_invalid_password).to be_false }
		end
	end
	
	describe "password not present" do
		before { @user = User.new(name: "Example User", email: "euser@example.com", password: " ", password_confirmation: " ") }
		it { should_not be_valid }
	end
	describe "password does not match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end
	
	describe "email not present" do
		before  { @user.email = " " }
		it { should_not be_valid }
	end
	describe "email formatis invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				expect(@user).not_to be_valid
			end
		end
	end
	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user).to be_valid
			end
		end
	end
	describe "email address is already registered" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
		it { should_not be_valid }
	end
end
