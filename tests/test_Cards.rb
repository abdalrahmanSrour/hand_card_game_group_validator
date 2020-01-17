#!/usr/bin/ruby -w

require_relative "../src/Cards.rb"
require_relative "Test.rb"


def test_CardRank_charToRank()
    puts CardRank::CARD_RANK_2
    puts CardRankFactory.strToRank("Q");
    puts CardRankFactory.strToRank(5);
end # test


test_CardRank_charToRank()