require 'rspec'
require 'spec_helper'
require 'json'
require_relative '../backend/model/mixins/four_id_generator'

describe 'FourIdGenerator' do

  it "understands what a fiscal year is" do
    FourIdGenerator.accession_fy_generator.call({'accession_date' => '2013-07-01'}).should eq('2014')
    FourIdGenerator.accession_fy_generator.call({'accession_date' => '2013-06-01'}).should eq('2013')
  end
  
  it "reports an error if id_0 has no value" do
    opts = {:id_0 => nil}
    resource = create_resource(opts)
    JSON.parse(resource.identifier).first.should_not be_nil 
  end

end
