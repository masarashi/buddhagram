require 'rails_helper'

RSpec.describe User, type: :model do
  # 名前、メールアドレス、パスワードがあれば有効な状態であること
  # it "is valid with a name, email, and password" do
  #   user = User.new(
  #     name:     "John",
  #     email:    "tester@example.com",
  #     password: "hogehoge"
  #   )
  #   expect(user).to be_valid
  # end

  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # 名前がなければ無効な状態であること
  it "is invalid without a name" do
    # user = User.new(name: nil)
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
    puts user.inspect # nil, tester6@
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without a email" do
    # user = User.new(email: nil)
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
    puts user.inspect # John, nil
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email" do
    # User.create(
    #   name:     "John",
    #   email:    "tester@example.com",
    #   password: "hogehoge"
    # )
    # user = User.new(
    #   name:     "Jacob",
    #   email:    "tester@example.com",
    #   password: "hogehoge"
    # )
    FactoryBot.create(:user, email: "john@example.com")
    user = FactoryBot.build(:user, email: "john@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
    puts user.inspect # John john@
  end
end