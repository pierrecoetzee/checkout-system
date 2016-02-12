require 'spec_helper'
require 'ostruct'
require_relative '../../../lib/rules'

describe LavenderHeart do

  let(:lavender_heart){OpenStruct.new(sku: 001, price: 9.25 )}
  let(:cufflinks){OpenStruct.new( sku: 002, price: 45.00)}
  let(:tshirt){OpenStruct.new(sku: 003, price: 19.95)}


  describe '#execute' do
    let(:basket){[lavender_heart, lavender_heart, lavender_heart] }

    context 'when the rule can be applied' do

       it 'calls #new_price' do
         expect(subject).to receive(:new_price)
         subject.execute(basket)
       end

       it 'returns 25.50' do
         expect(subject.execute(basket)).to eq 25.50
       end
    end

    context 'when the rule can not be applied' do

      before do
        allow(subject).to receive(:can_apply_rule?){false}
      end

      it 'does not call #new_price' do
        expect(subject).to_not receive(:new_price)
        subject.execute(basket)
      end

      it 'returns 0.00' do
       expect(subject.execute(basket)).to eq 0.00
      end
    end
  end
end