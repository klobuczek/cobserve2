require File.dirname(__FILE__) + '/../test_helper'

class DayTest < Test::Unit::TestCase
  
  def test_find_by_date1
    User.create!(:login =>"nick", :password => "password", :password_confirmation => "password", :email => "email@domain.com").days << Day.new(:date => Date.today())
    assert_equal Date.today, Day.find_by_date(Date.today).date
  end   
  
  def test_find_by_date2
    assert_nil Day.find_by_date(Date.today)
  end
  
  def test_create_day
    User.create!(:login=>"nick", :password => "password", :password_confirmation => "password", :email => "email@domain.com").days << Day.new(:date => Date.today(),
 "time"=>"7:00")
    assert_equal Date.today, Day.find_by_date(Date.today).date
 
  end
  
  #  def test_trivial
  #     assert Day.find_by_date( Date.civil(2008,02,12) ).trivial?
  #  end   
  #  def test_nontrivial
  #    assert !Day.new(:temperature => 30).trivial?
  #  end   
  #  def test_trivial2
  #    assert Day.new(:user_id => 30).trivial?
  #  end   
end
