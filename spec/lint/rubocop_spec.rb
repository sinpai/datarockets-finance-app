require 'spec_helper'

describe 'Check that the files have correct syntax' do
  before do
    @report = `rubocop -l`
    puts "Report: #{@report}"
  end

  it { @report.match('Offenses').should be nil }
end
