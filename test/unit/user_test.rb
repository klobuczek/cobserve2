require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase
  #  before :each do
  #    User.delete_all
  #    Day.delete_all
  #  end
  # Replace this with your real tests.
  def test_user_not_valid
    assert !User.new(:nick => 'a'*50).valid?
  end
  def test_user_valid
    assert new_user.valid?
  end
  def test_user_duplicate
    create_user
    assert !new_user.valid?
  end
  def test_day
    user = create_user
    user.days << Day.new(:date => Date.today())
    assert_equal Date.today, User.find(user.id).day(Date.today).date
  end
  def test_day
    assert_nil User.find(create_user.id).day(Date.today)
  end
  def test_cycle_start
    user = create_user
    add_day user, Date.today - 10, true
    add_day user, Date.today - 5
    add_day user, Date.today + 10, true
    
    assert_equal Date.today - 10,  User.find(user.id).days.cycle_start(Date.today-40, Date.today).date
  end
  def test_cycle_start_today
    user = create_user
    add_day user, Date.today - 10, true
    add_day user, Date.today , true
    add_day user, Date.today + 10, true
    
    assert_equal Date.today,  User.find(user.id).days.cycle_start(Date.today-40, Date.today).date
  end
  def test_cycle_start_empty
    assert_nil User.find(create_user.id).days.cycle_start(Date.today-40, Date.today)
  end
  def test_cycle_start_empty_past
    user = create_user
    add_day user, Date.today
    add_day user, Date.today + 10, true
    assert_nil User.find(user.id).days.cycle_start(Date.today-40, Date.today)
  end
  
  private
  def create_user
    User.create!(:nick=>"nick", :password => "password", :email => "email@domain.com")
  end
  def new_user
    User.new(:nick=>"nick", :password => "password", :email => "email@domain.com")
  end
  def add_day user, date, first=false
    user.days << Day.new(:date => date, :first => first )
  end
  
  
  
end
