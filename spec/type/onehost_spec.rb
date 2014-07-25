#!/usr/bin/env rspec

require 'spec_helper'

res_type_name = :onehost
res_type = Puppet::Type.type(res_type_name)

describe res_type do
  let(:provider) {
    prov = stub 'provider'
    prov.stubs(:name).returns(res_type_name)
    prov
  }
  let(:res_type) {
    val = res_type
    val.stubs(:defaultprovider).returns provider
    val
  }
#  let(:resource) {
#    res_type.new({:name => 'test'})
#  }
  before :each do
      @host = res_type.new(:name => 'test')
  end

  it 'should have :name be its namevar' do
    res_type.key_attributes.should == [:name]
  end

  it 'should have property :im_mad' do
      @host[:im_mad] = 'kvm'
      @host[:im_mad].should == 'kvm'
  end

  it 'should have property :vm_mad' do
      @host[:vm_mad] = 'kvm'
      @host[:vm_mad].should == 'kvm'
  end

  it 'should have property :tm_mad' do
      @host[:tm_mad] = 'ssh'
      @host[:tm_mad].should == 'ssh'
  end

  it 'should have property :cluster' do
      @host[:cluster] = 'cluster1'
      @host[:cluster].should == 'cluster1'
  end

  parameter_tests = {
    :name => {
      :valid => ["test", "foo"],
      :default => "test",
      :invalid => ["0./fouzb&$", "&fr5"],
    },
# :im_mad => {
# },
# :vm_mad => {
# },
# :tm_mad => {
# },
  }
  it_should_behave_like "a puppet type", parameter_tests, res_type_name
end