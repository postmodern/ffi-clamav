require 'spec_helper'
require 'ffi/clamav/engine'

describe FFI::ClamAV::Engine do
  describe "#initialize" do
    context "when given no arguments" do
      it "should create a new engine" do
        engine = subject

        engine.should_not be_null
      end
    end
  end

  describe "#settings" do
    it "should return a new Settings object" do
      subject.settings.should be_kind_of(FFI::ClamAV::Settings)
    end
  end

  describe "#settings=" do
    let(:other_engine) { described_class.new }
    let(:max_scansize) { 1024 }

    before { other_engine.max_scansize = max_scansize }

    it "should apply settings to the engine" do
      subject.settings = other_engine.settings

      subject.max_scansize.should == max_scansize
    end
  end

  describe "fields" do
    describe "defaults" do
      its(:max_scansize) { should == 100 * (1024 ** 2) }
      its(:max_filesize) { should == 25 * (1024 ** 2) }
      its(:max_recursion) { should == 16 }
      its(:max_files) { should == 10000 }
      its(:min_cc_count) { should == 3 }
      its(:min_ssn_count) { should == 3 }
      its(:pua_categories) { should == nil }
      its(:db_options) { should == 0 }
      its(:db_version) { should == 0 }
      its(:db_time) { should == Time.parse("1969-12-31 16:00:00 -0800") }
      its(:ac_only) { should == 0 }
      its(:ac_mindepth) { should == 2 }
      its(:ac_maxdepth) { should == 3 }
      its(:tmpdir) { should == nil }
      its(:keeptmp) { should == 0 }
      its(:bytecode_security) { should == :trust_signed }
      its(:bytecode_timeout) { should == 60000 }
      its(:bytecode_mode) { should == :auto }
    end
  end

  describe "#load!" do
    it "should load signatures from the Database directory" do
      subject.load!.should > 0
    end
  end

  describe "#compile!" do
    it "should compile the engine" do
      subject.compile!.should == :success
    end
  end
end
