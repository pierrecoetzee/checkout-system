require 'spec_helper'
require_relative '../../../lib/rules'

describe OverSixtyPound do

  describe '#execute' do
     context 'when the total is over £60' do
       it 'returns 54.01 as the 10% discounted amount' do
         expect(subject.execute(60.01)).to eq 54.01
       end
     end

     context 'when the total is under £60' do
       it 'returns 60.00 as the 10% discounted amount' do
         expect(subject.execute(59.99)).to eq 59.99
       end
     end

  end
end