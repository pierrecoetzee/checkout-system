require 'ostruct'
require 'spec_helper'
require_relative '../../lib/checkout'
require_relative '../../lib/rules'

describe Checkout do

  let(:lavender_heart){OpenStruct.new(sku: 001, price: 9.25 )}
  let(:cufflinks){OpenStruct.new( sku: 002, price: 45.00)}
  let(:tshirt){OpenStruct.new(sku: 003, price: 19.95)}

  subject{described_class.new(rules: []) }

  describe '#scan' do

    it 'can add items to the items collection' do
      subject.scan lavender_heart
      subject.scan cufflinks
      subject.scan tshirt
      expect(subject.items).to eq [lavender_heart, cufflinks,tshirt ]
    end

  end

  describe '#total' do

      let(:basket){ [lavender_heart, cufflinks, tshirt] }
      let(:over_sixty_rule){ OverSixtyPound.new }
      let(:lavender_heart_rule){ LavenderHeart.new }

      before{ scan_basket basket }

      context '001,002,003 skus are scanned' do
        subject do
           described_class.new rules: [over_sixty_rule]
        end

        it 'returns £66.78' do
           expect(subject.total).to eq 66.78
        end
      end

      context '001,003,001 skus are scanned' do

        let(:basket){ [lavender_heart, tshirt, lavender_heart] }

        subject do
           described_class.new rules: [lavender_heart_rule]
        end

        it 'returns £36.95' do
          expect(subject.total).to eq 36.95
        end
      end

      context '001,002,001,003 skus are scanned' do

        let(:basket){ [lavender_heart, cufflinks, lavender_heart, tshirt] }

        subject do
           described_class.new rules: [lavender_heart_rule, over_sixty_rule]
        end

        it 'returns £73.76' do
          expect(subject.total).to eq 73.76
        end
      end

      describe 'checkout without no rules' do
         let(:basket){ [lavender_heart, cufflinks, tshirt] }

         subject do
            described_class.new rules: []
         end

         it 'returns £74.20' do
           expect(subject.total).to eq 74.20
         end
      end
  end

  private
  def scan_basket basket
    basket.each{|b| subject.scan b }
  end

end
