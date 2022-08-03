require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "name_validation" do
    # 入力必須
    user = User.new(email: "test@example.com", password: "password")
    user.save
    max = 30
    name = "あ" * max
    user.name = name
    assert_difference("User.count", 1) do
      user.save
    end
    puts user.name
    puts user.id
    puts user.password
    puts User.count
  end

  test "email_validation" do

    
    # 入力必須
    user = User.new(name: "test", password: "password")
    user.save
    max = 255
    domain = "@example.com"
    email = "a" * ((max + 1) - domain.length) + domain
    puts email.length
    puts max
    assert max < email.length

    user.email = email
    user.save
    maxlength_msg = ["メールアドレスは255文字以内で入力してください"]
    assert_equal(maxlength_msg, user.errors.full_messages)  
  end

  test "active_user_uniqueness" do
    email = "test@example.com"

    # アクティブユーザーがいない場合、同じメールアドレスが登録できているか
    count = 5
    assert_difference("User.count", count) do
      count.times do |n|
        User.create(name: "test", email: email, password: "password")
      end
    end
  end
  
end
