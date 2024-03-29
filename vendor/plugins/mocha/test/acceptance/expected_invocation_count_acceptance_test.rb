require File.join(File.dirname(__FILE__), "..", "test_helper")
require 'mocha'
require 'test_runner'

class ExpectedInvocationCountAcceptanceTest < Test::Unit::TestCase

  include TestRunner

  def test_should_pass_if_method_is_never_expected_and_is_never_called
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).never
      0.times { mock.method }
    end
    assert_passed(test_result)
  end
  
  def test_should_fail_if_method_is_never_expected_but_is_called_once
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).never
      1.times { mock.method }
    end
    assert_failed(test_result)
    assert_equal ["not all expectations were satisfied\nunsatisfied expectations:\n  expected never, already invoked 1 time: #<Mock:mock>.method(any_parameters)\n"], test_result.failure_messages
  end
  
  def test_should_pass_if_method_is_expected_twice_and_is_called_twice
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).times(2)
      2.times { mock.method }
    end
    assert_passed(test_result)
  end
  
  def test_should_fail_if_method_is_expected_twice_but_is_called_once
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).times(2)
      1.times { mock.method }
    end
    assert_failed(test_result)
    assert_equal ["not all expectations were satisfied\nunsatisfied expectations:\n  expected exactly 2 times, already invoked 1 time: #<Mock:mock>.method(any_parameters)\n"], test_result.failure_messages
  end
  
  def test_should_fail_if_method_is_expected_twice_but_is_called_three_times
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).times(2)
      3.times { mock.method }
    end
    assert_failed(test_result)
    assert_equal ["not all expectations were satisfied\nunsatisfied expectations:\n  expected exactly 2 times, already invoked 3 times: #<Mock:mock>.method(any_parameters)\n"], test_result.failure_messages
  end
  
  def test_should_pass_if_method_is_expected_between_two_and_four_times_and_is_called_twice
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).times(2..4)
      2.times { mock.method }
    end
    assert_passed(test_result)
  end

  def test_should_pass_if_method_is_expected_between_two_and_four_times_and_is_called_three_times
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).times(2..4)
      3.times { mock.method }
    end
    assert_passed(test_result)
  end

  def test_should_pass_if_method_is_expected_between_two_and_four_times_and_is_called_four_times
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).times(2..4)
      4.times { mock.method }
    end
    assert_passed(test_result)
  end

  def test_should_fail_if_method_is_expected_between_two_and_four_times_and_is_called_once
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).times(2..4)
      1.times { mock.method }
    end
    assert_failed(test_result)
    assert_equal ["not all expectations were satisfied\nunsatisfied expectations:\n  expected between 2 and 4 times, already invoked 1 time: #<Mock:mock>.method(any_parameters)\n"], test_result.failure_messages
  end

  def test_should_fail_if_method_is_expected_between_two_and_four_times_and_is_called_five_times
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).times(2..4)
      5.times { mock.method }
    end
    assert_failed(test_result)
    assert_equal ["not all expectations were satisfied\nunsatisfied expectations:\n  expected between 2 and 4 times, already invoked 5 times: #<Mock:mock>.method(any_parameters)\n"], test_result.failure_messages
  end
  
  def test_should_pass_if_method_is_expected_at_least_once_and_is_called_once
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).at_least_once
      1.times { mock.method }
    end
    assert_passed(test_result)
  end
  
  def test_should_pass_if_method_is_expected_at_least_once_and_is_called_twice
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).at_least_once
      2.times { mock.method }
    end
    assert_passed(test_result)
  end
  
  def test_should_fail_if_method_is_expected_at_least_once_but_is_never_called
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).at_least_once
      0.times { mock.method }
    end
    assert_failed(test_result)
    assert_equal ["not all expectations were satisfied\nunsatisfied expectations:\n  expected at least once, never invoked: #<Mock:mock>.method(any_parameters)\n"], test_result.failure_messages
  end
  
  def test_should_pass_if_method_is_expected_at_most_once_and_is_never_called
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).at_most_once
      0.times { mock.method }
    end
    assert_passed(test_result)
  end
  
  def test_should_pass_if_method_is_expected_at_most_once_and_called_once
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).at_most_once
      1.times { mock.method }
    end
    assert_passed(test_result)
  end
  
  def test_should_fail_if_method_is_expected_at_most_once_but_is_called_twice
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).at_most_once
      2.times { mock.method }
    end
    assert_failed(test_result)
    assert_equal ["not all expectations were satisfied\nunsatisfied expectations:\n  expected at most once, already invoked 2 times: #<Mock:mock>.method(any_parameters)\n"], test_result.failure_messages
  end
  
  def test_should_pass_if_method_is_never_expected_and_is_never_called_even_if_everything_is_stubbed
    test_result = run_test do
      stub = stub_everything('stub')
      stub.expects(:method).never
      0.times { stub.method }
    end
    assert_passed(test_result)
  end
  
  def test_should_fail_if_method_is_never_expected_but_is_called_once_even_if_everything_is_stubbed
    test_result = run_test do
      stub = stub_everything('stub')
      stub.expects(:method).never
      1.times { stub.method }
    end
    assert_failed(test_result)
    assert_equal ["not all expectations were satisfied\nunsatisfied expectations:\n  expected never, already invoked 1 time: #<Mock:stub>.method(any_parameters)\n"], test_result.failure_messages
  end
  
  def test_should_fail_if_there_is_no_matching_expectation
    test_result = run_test do
      mock = mock('mock')
      mock.expects(:method).with(1)
      1.times { mock.method }
    end
    assert_failed(test_result)
    assert_equal ["unexpected invocation: #<Mock:mock>.method()\nunsatisfied expectations:\n  expected exactly once, never invoked: #<Mock:mock>.method(1)\n"], test_result.failure_messages
  end
  
end
