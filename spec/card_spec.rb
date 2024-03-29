require_relative '../lib/card'

RSpec.describe Card do
  describe '#initialize' do
    it 'creates a card assigned with suit and value' do
      card = Card.new('Spades', 'Ace')
      expect(card.suit).to eq('Spades')
      expect(card.value).to eq('Ace')
    end

    it 'raises an error for invalid suit' do
      expect { Card.new('InvalidSuit', 'Ace') }.to raise_error(ArgumentError)
    end

    it 'raises an error for invalid value' do
      expect { Card.new('Spades', 'InvalidValue') }.to raise_error(ArgumentError)
    end
  end

  # returns card name better formatted. maybe a destiny reference, maybe one piece who knows
  describe '#to_s' do
    it 'returns the card in a string' do
      card = Card.new('Spades', 'Ace')
      expect(card.to_s).to eq('Ace of Spades')
    end
  end
end

#i have been working on this since 10am yesterday and its noon the next day. I give up. It says I have too many end statements
# but my roomates doesnt do that, only mine does that, it wont let me close out the file and it wont tell me whats wrong and its infuriating
