#!/usr/bin/ruby -w

module CardRank
    CARD_RANK_UNDEFINED = 0
    CARD_RANK_2 = 2
    CARD_RANK_3 = 3
    CARD_RANK_4 = 4
    CARD_RANK_5 = 5
    CARD_RANK_6 = 6
    CARD_RANK_7 = 7
    CARD_RANK_8 = 8
    CARD_RANK_9 = 9
    CARD_RANK_10 = 10
    CARD_RANK_J = 11
    CARD_RANK_Q = 12
    CARD_RANK_K = 13
    CARD_RANK_A = 1

    ##
    ## strToRank method convert @p c to CardRank
    ## if the string has one character match one of the Cards rank 
    ## {2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A}
    ## otherwise it will return CardRank::CARD_RANK_UNDEFINED!
    ##
    ## Params:
    ##  c : @type String
    ##      Input value to be converted
    ##
    ## return:
    ##  CardRank
    ##      the match value, or CARD_RANK_UNDEFINED if no match
    ##
    ## throws:
    ##  ArgumentError
    ##      If @p c is not a string
    ##
    def strToRank(c)
        raise ArgumentError, '\'c\' argument is not a string' unless c.is_a? String
        case c
            when "A", "a"
                return CardRank::CARD_RANK_A;
            when "2"
                return CardRank::CARD_RANK_2;
            when "3"
                return CardRank::CARD_RANK_3;
            when "4"
                return CardRank::CARD_RANK_4;
            when "5"
                return CardRank::CARD_RANK_5;
            when "6"
                return CardRank::CARD_RANK_6;
            when "7"
                return CardRank::CARD_RANK_7;
            when "8"
                return CardRank::CARD_RANK_8;
            when "9"
                return CardRank::CARD_RANK_9;
            when "10"
                return CardRank::CARD_RANK_10;
            when "J", "j"
                return CardRank::CARD_RANK_J;
            when "Q", "q"
                return CardRank::CARD_RANK_Q;
            when "K", "k"
                return CardRank::CARD_RANK_K;
            else
                return CardRank::CARD_RANK_UNDEFINED;
        end # case
    end # charToRank
end # module CardRank

class CardRankFactory
    extend CardRank
end # class CardRankFactory

module CardSuit
    CARD_SUIT_UNDEFINED = 0
    CARD_SUIT_HEART = 1
    CARD_SUIT_SPADES = 2
    CARD_SUIT_CLUBS = 3
    CARD_SUIT_DIAMODS = 4
    CARD_SUIT_JOKER = 5

    ##
    ## strToSuit method convert @p c to CardSuit
    ## if the string has one character match one of the Cards suits 
    ## {h -> Hearts, s -> Spades, c -> Clubs, d -> Diamonds, j -> Joker}
    ## otherwise it will return CardSuit::CARD_SUIT_UNDEFINED!
    ##
    ## Params:
    ##  c : @type String
    ##      Input value to be converted
    ##
    ## return:
    ##  CardSuit
    ##      the match value, or CARD_SUIT_UNDEFINED if no match
    ##
    ## throws:
    ##  ArgumentError
    ##      If @p c is not a string
    ##
    def strToSuit(c)
        raise ArgumentError, '\'c\' argument is not a string' unless c.is_a? String
        case c
            when "H", "h"
                return CardSuit::CARD_SUIT_HEART;
            when "C", "c"
                return CardSuit::CARD_SUIT_CLUBS;
            when "D", "d"
                return CardSuit::CARD_SUIT_DIAMODS;
            when "S", "s"
                return CardSuit::CARD_SUIT_SPADES;
            when "J", "j"
                return CardSuit::CARD_SUIT_JOKER;
            else
                return CardSuit::CARD_SUIT_UNDEFINED;
        end # case
    end # strToSuit
end # module CardSuit

class CardSuitFactory
    extend CardSuit
end # class CardSuitFactory

class Card
    def initialize(name)
        setName(name)
    end # initialize

    def setName(name)
        raise ArgumentError, '\'name\' argument is not a string' unless name.is_a? String
        raise ArgumentError, "'name' argument is not a valid cc = #{name.length}" unless name.length >= 2 and name.length <= 3

        @name = name;
        s_start = name.length - 1;
        @suit = CardSuitFactory.strToSuit(name[s_start, 1]);
        if @suit == CardSuit::CARD_SUIT_JOKER
            if name[0, s_start] != "1" && name[0, s_start] != "2"
                raise ArgumentError, "'name' argument is not a valid Joker"
            end # if

            @rank = CardRank::CARD_RANK_UNDEFINED;
        else
            @rank = CardRankFactory.strToRank(name[0, s_start]);
        end # if
    end

    def name
        @name
    end

    def rank
        @rank
    end
    def suit
        @suit
    end

end # class Card