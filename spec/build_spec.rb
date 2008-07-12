require File.dirname(__FILE__) + '/spec_helper'

describe Integrity::Build do
  before(:each) do
    @build = Integrity::Build.new
  end

  it 'should not be valid' do
    @build.should_not be_valid
  end

  it "needs an output, a status, and a commit" do
    @build.attributes = {
      :commit => {
        :author => 'Simon Rozet <simon@rozet.name>',
        :identifier => '712041aa093e4fb0a2cb1886db49d88d78605396',
        :message    => 'started build model'
      },
      :output => 'foo',
      :status => true
    }
    @build.should be_valid
  end

  it 'should have output' do
    @build.output = 'foo'
    @build.output.should == 'foo'
  end

  it 'should have error' do
    @build.error = 'err!'
    @build.error.should == 'err!'
  end

  it 'should have a status' do
    @build.status = true
    @build.should be_success
  end

  it 'should default to failure' do
    @build.should be_failure
    @build.should_not be_success
  end

  it 'should have a commit' do
    @build.commit = {
      :author => 'Simon Rozet <simon@rozet.name>',
      :identifier => '712041aa093e4fb0a2cb1886db49d88d78605396',
      :message    => 'started build model'
    }
    @build.commit[:author].should == 'Simon Rozet <simon@rozet.name>'
  end

  specify 'output should default to ""' do
    @build.output.should == ''
  end

  specify 'error should default to ""' do
    @build.error.should == ''
  end

  specify '#human_readable_status should return "success" or "fail", depending on status' do
    @build.stub!(:status).and_return(true)
    @build.human_readable_status.should == 'Successful'
    @build.stub!(:status).and_return(false)
    @build.human_readable_status.should == 'Fail'
  end
end