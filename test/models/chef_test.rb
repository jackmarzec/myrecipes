require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create! (chefname: "Jack", email: "jack@example.coms")
    @chef = @chef.recipes.build(chefname: "Jack", email: "jack@example.com")
  end

  test "recipe without chef should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?


  test "should be valid" do
    assert_not @chef.valid?
  end

test "name should be present" do
  @chef.chefname = " "
  assert_not @chef.valid?
  end

  test "name should be less than 30 characters" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end


  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email should not be too long" do
    @chef.email = 'a' * 245 + "@example.com"
    assert_not @chef.valid?
  end

  test "email should accept correct format" do
    valid_emails = %w[user@example.com Jack@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
    @chef.email = valids
    assert_not @chef.valid?, "#{valids.inspect} should be valid"
    end
  end


  test "should reject invalid addresses" do
      invalid_emails = %w[jack@example jack@example,com jack.name@gmail. joe@barfoo.com]
      invalid_emails.each do |invalids|
        @chef.email = invalids
        assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
    end
  end

   test "email should be unique and case insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
   end

  test 'email should be lower case before hitting db' do
   mixed_email = 'JaCk@Example.com'
   @chef.email = mixed_email
   @chef.save
   assert_equal mixed_email.downcase, @chef.reload.email
  end
end