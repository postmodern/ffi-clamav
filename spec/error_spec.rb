require 'spec_helper'

require 'ffi/clamav/error'

describe Error do
  let(:type) { :virus }

  describe "#initialize" do
    let(:message) { "Virus(es) detected" }

    it "should map an error type to a error message" do
      described_class.new(type).message.should == message
    end
  end

  describe "catch" do
    context "when :clean is returned" do
      it "should return true" do
        described_class.catch { :clean }.should == true
      end
    end

    context "when :success is returned" do
      it "should return true" do
        described_class.catch { :success }.should == true
      end
    end

    context "otherwise" do
      it "should raise an Error" do
        lambda {
          described_class.catch { type }
        }.should raise_error(described_class)
      end
    end
  end
end
