require File.dirname(__FILE__) + '/../test_helper'

class CycleTest < Test::Unit::TestCase
  
  def test_find_by_user_and_date
    assert_equal Date.today, Cycle.find_by_user_and_date(user([0]),Date.today).day.date
  end
  
  def test_find_by_user_and_date_far_back
    assert_nil Cycle.find_by_user_and_date(user([-40]),Date.today)
  end
  
  def test_find_by_user_and_date_back
    assert_equal Date.today-20, Cycle.find_by_user_and_date(user([-20,10], [-15,-5,0,5]),Date.today).day.date
  end
  
  def test_find_by_user_and_date_future
    assert_nil Cycle.find_by_user_and_date(user([20]),Date.today)
  end
  
  def test_end_cycle
    assert_equal Date.today + 20, Cycle.find_by_user_and_date(user([-10,20]),Date.today).ende
  end
  def test_end_cycle_28
    assert_equal Date.today + 18, Cycle.find_by_user_and_date(user([-10]),Date.today).ende
  end
  def test_end_cycle_28_to_40
    assert_equal Date.today + 1, Cycle.find_by_user_and_date(user([-30]),Date.today).ende
  end
  def test_end_cycle_40
    assert_equal Date.today - 10, Cycle.find_by_user_and_date(user([-50]),Date.today-20).ende
  end
  def test_first_cycle
    assert_equal 0, Cycle.find_by_user_and_date(user([0]),Date.today).fertility_begin
  end
  
  def test_find_by_user_and_id
    u1 = user([0])
    cycle = Cycle.find_by_user_and_date(u1,Date.today)
    assert_equal Date.today, Cycle.find_by_user_and_id(u1,cycle.id).day.date
  end
  

  
  private
  def create_user
    User.create!(:login=>"nick", :password => "password", :password_confirmation => "password", :email => "email@domain.com")
  end
  def add_days user, diffs, first=false
    diffs.each {|d| user.days << Day.new(:date => (Date.today + d), :first => first) }
  end
  def user cycles, days=[]
    user = create_user
    add_days user, cycles, true
    add_days user, days
    user
  end
  
end
