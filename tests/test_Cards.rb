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
    test.checkIfIntEQ(CardSuitFactory.strToSuit("J"), CardSuit::CARD_SUIT_UNDEFINED, __LINE__, __FILE__);
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


$testsList = Hash[
    "CardRank strToRank" => method(:test_CardRank_strToRank),
    "CardSuit strToSuit" => method(:test_CardSuit_strToSuit)
]

$test = SR_Test.new("Test Cards", $testsList)
$test.run()
