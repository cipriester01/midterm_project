require '../lib/card'

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
