#!/usr/bin/ruby -w

require_relative "../src/Cards.rb"
require_relative "Test.rb"


def test_CardRank_strToRank(test)
    test.checkIfIntEQ(CardRankFactory.strToRank("Q"), CardRank::CARD_RANK_Q, __LINE__, __FILE__);
    test.checkIfIntEQ(CardRankFactory.strToRank("q"), CardRank::CARD_RANK_Q, __LINE__, __FILE__);
    test.checkIfIntEQ(CardRankFactory.strToRank("a"), CardRank::CARD_RANK_A, __LINE__, __FILE__);
    test.checkIfIntEQ(CardRankFactory.strToRank("10"), CardRank::CARD_RANK_10, __LINE__, __FILE__);
    test.checkIfIntEQ(CardRankFactory.strToRank("3"), CardRank::CARD_RANK_3, __LINE__, __FILE__);
    test.checkIfIntEQ(CardRankFactory.strToRank("33"), CardRank::CARD_RANK_UNDEFINED, __LINE__, __FILE__);
    test.checkIfIntEQ(CardRankFactory.strToRank("AB"), CardRank::CARD_RANK_UNDEFINED, __LINE__, __FILE__);
    begin
        CardRankFactory.strToRank(0)
        test.checkIf(false, __LINE__, __FILE__); # force fail
    rescue
    end
    begin
        CardRankFactory.strToRank(true)
        test.checkIf(false, __LINE__, __FILE__); # force fail
    rescue
    end
    begin
        CardRankFactory.strToRank(1000)
        test.checkIf(false, __LINE__, __FILE__); # force fail
    rescue
    end
    test.checkIfIntEQ(CardRankFactory.strToRank("A"), CardRankFactory.strToRank("a"), __LINE__, __FILE__);
    test.checkIfIntEQ(CardRankFactory.strToRank("J"), CardRankFactory.strToRank("j"), __LINE__, __FILE__);
    test.checkIfIntEQ(CardRankFactory.strToRank("Q"), CardRankFactory.strToRank("q"), __LINE__, __FILE__);
end # test_CardRank_strToRank

def test_CardSuit_strToSuit(test)
    test.checkIfIntEQ(CardSuitFactory.strToSuit("H"), CardSuit::CARD_SUIT_HEART, __LINE__, __FILE__);
    test.checkIfIntEQ(CardSuitFactory.strToSuit("S"), CardSuit::CARD_SUIT_SPADES, __LINE__, __FILE__);
    test.checkIfIntEQ(CardSuitFactory.strToSuit("C"), CardSuit::CARD_SUIT_CLUBS, __LINE__, __FILE__);
    test.checkIfIntEQ(CardSuitFactory.strToSuit("D"), CardSuit::CARD_SUIT_DIAMODS, __LINE__, __FILE__);
    test.checkIfIntEQ(CardSuitFactory.strToSuit("J"), CardSuit::CARD_SUIT_JOKER, __LINE__, __FILE__);
    test.checkIfIntEQ(CardSuitFactory.strToSuit("A"), CardSuit::CARD_SUIT_UNDEFINED, __LINE__, __FILE__);
    test.checkIfIntEQ(CardSuitFactory.strToSuit("Z"), CardSuit::CARD_SUIT_UNDEFINED, __LINE__, __FILE__);
    test.checkIfIntEQ(CardSuitFactory.strToSuit("33"), CardSuit::CARD_SUIT_UNDEFINED, __LINE__, __FILE__);
    test.checkIfIntEQ(CardSuitFactory.strToSuit("AB"), CardSuit::CARD_SUIT_UNDEFINED, __LINE__, __FILE__);
    begin
        CardSuitFactory.strToSuit(0)
        test.checkIf(false, __LINE__, __FILE__); # force fail
    rescue
    end
    begin
        CardSuitFactory.strToSuit(true)
        test.checkIf(false, __LINE__, __FILE__); # force fail
    rescue
    end
    begin
        CardSuitFactory.strToSuit(1000)
        test.checkIf(false, __LINE__, __FILE__); # force fail
    rescue
    end
    test.checkIfIntEQ(CardSuitFactory.strToSuit("H"), CardSuitFactory.strToSuit("h"), __LINE__, __FILE__);
    test.checkIfIntEQ(CardSuitFactory.strToSuit("C"), CardSuitFactory.strToSuit("c"), __LINE__, __FILE__);
    test.checkIfIntEQ(CardSuitFactory.strToSuit("j"), CardSuitFactory.strToSuit("J"), __LINE__, __FILE__);
end # test_CardRank_strToRank

def test_Card(test)
    begin
        $card = Card.new;
        test.checkIf(false, __LINE__, __FILE__); # force fail
    rescue
    end
    begin
        $card = Card.new("");
        test.checkIf(false, __LINE__, __FILE__); # force fail
    rescue
    end
    $card = Card.new("Ah");
    test.checkIf($card);
    test.checkIfIntEQ($card.rank, CardRank::CARD_RANK_A);
    test.checkIfIntEQ($card.suit, CardSuit::CARD_SUIT_HEART);

    $card = Card.new("1j");
    test.checkIf($card);
    test.checkIfIntEQ($card.rank, CardRank::CARD_RANK_UNDEFINED);
    test.checkIfIntEQ($card.suit, CardSuit::CARD_SUIT_JOKER);
    ["Ah", "AC", "As", "3h", "4h", "5h", "6h", "7h", "10h", "10d", "10c"].each do |d|
        $card = Card.new(d);
        test.checkIf($card);
        test.checkIfIntNE($card.rank, CardRank::CARD_RANK_UNDEFINED);
        test.checkIfIntNE($card.suit, CardSuit::CARD_SUIT_UNDEFINED);
    end # each
end # test_Card


$testsList = Hash[
    "CardRank strToRank" => method(:test_CardRank_strToRank),
    "CardSuit strToSuit" => method(:test_CardSuit_strToSuit),
    "Card Class" => method(:test_Card)
]

$test = SR_Test.new("Test Cards", $testsList)
$test.run()
