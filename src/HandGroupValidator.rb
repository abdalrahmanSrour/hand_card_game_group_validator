#!/usr/bin/ruby -w

require_relative "Cards.rb"

def convertArrayToCards(group)
    raise unless caller[0].split(':')[0] == __FILE__
    raise ArgumentError, '\'group\' argument is not an Array' unless group.is_a? Array

    cards = Array.new
    group.each do |cname|
        begin
            c = Card.new(cname)
            cards.push(c);
        rescue ArgumentError => e
            puts "E: Can't parse cards, error:"
            puts "#{e.class}: #{e.message}"
            puts e.backtrace.join("\n")
            return nil
        end
    end # group.each
    return cards
end # convertArrayToCards

def checkIfValidCards(cards)
    raise unless caller[0].split(':')[0] == __FILE__
    raise ArgumentError, '\'cards\' argument is not an Array' unless cards.is_a? Array

    $jokers = 0;
    cards.each do |c|
        if c.suit == CardSuit::CARD_SUIT_JOKER
            $jokers += 1;
            if $jokers > 2
                puts "E: More than 2 jokers in group!"
                return false
            end
        end

        if c.suit == CardSuit::CARD_SUIT_UNDEFINED
            puts "E: Undefined Suit for name=#{c.name}, suit=#{c.suit}, rank=#{c.rank}"
            return false
        end

        if c.suit == CardSuit::CARD_SUIT_JOKER and c.rank != CardRank::CARD_RANK_UNDEFINED
            puts "E: Invalid Joker number for name=#{c.name}, suit=#{c.suit}, rank=#{c.rank}"
            return false
        end

        if c.suit != CardSuit::CARD_SUIT_JOKER and c.rank == CardRank::CARD_RANK_UNDEFINED
            puts "E: Invalid card for name=#{c.name}, suit=#{c.suit}, rank=#{c.rank}"
            return false
        end
    end
    return true
end

def isSameRank(cards)
    raise unless caller[0].split(':')[0] == __FILE__
    raise ArgumentError, '\'cards\' argument is not an Array' unless cards.is_a? Array

    $rank = CardRank::CARD_RANK_UNDEFINED
    cards.each do |c|
        if c.suit == CardSuit::CARD_SUIT_JOKER
            # skip
        elsif $rank == CardRank::CARD_RANK_UNDEFINED
            $rank = c.rank
        else
            if $rank != c.rank
                return false
            end # if
        end # if
    end # cards.each

    return true
end # isSameRank

def isSameSuit(cards)
    raise unless caller[0].split(':')[0] == __FILE__
    raise ArgumentError, '\'cards\' argument is not an Array' unless cards.is_a? Array

    $suit = CardRank::CARD_RANK_UNDEFINED
    cards.each do |c|
        if c.suit == CardSuit::CARD_SUIT_JOKER
            # skip
        elsif $suit == CardRank::CARD_RANK_UNDEFINED
            $suit = c.suit
        else
            if $suit != c.suit
                return false
            end # if
        end # if
    end # cards.each

    return true
end # isSameSuit

def validSameRankGroup(cards)
    raise unless caller[0].split(':')[0] == __FILE__
    raise ArgumentError, '\'cards\' argument is not an Array' unless cards.is_a? Array

    if $cards.count > 4
        return false;
    end
    
    $suits = Hash[
        CardSuit::CARD_SUIT_HEART => 0,
        CardSuit::CARD_SUIT_SPADES => 0,
        CardSuit::CARD_SUIT_CLUBS => 0,
        CardSuit::CARD_SUIT_DIAMODS => 0
    ]
    cards.each do |c|
        if c.suit == CardSuit::CARD_SUIT_JOKER
            # skip
        elsif c.suit == CardRank::CARD_RANK_UNDEFINED
            # something wrong this should never happened
            puts "E: Invalid card name=#{c.name}";
            return false
        else
            if $suits[c.suit] > 0
                return false
            end # if
            $suits[c.suit] += 1;
        end # if
    end # cards.each

    return true
end # validSameRankGroup

def convertJokersRec(cards, slop, index, prev)
    if index == cards.count # last!
        return CardSuit::CARD_RANK_UNDEFINED
    end

    c = cards[index]

    if c.suit == CardSuit::CARD_SUIT_JOKER
        if prev == CardSuit::CARD_RANK_UNDEFINED
            nextc = convertJokersRec(cards, slop, index + 1, prev);
            if nextc != CardSuit::CARD_RANK_UNDEFINED
                
            end
        else
        end
    else
    end

    if index == 0 # first one
        if c.suit != CardSuit::CARD_SUIT_JOKER
        end
    end
end

def validAdjacent(rank1, rank2, diff)
    if rank2 == CardRank::CARD_RANK_A
        if diff == 1 and rank1 == CardRank::CARD_RANK_K
            return true
        end
        return false # no other options
    end
    d = rank2 - rank1
    if d == diff
        return true
    end
    return false
end

def nextValidAdjacent(rank)
    if rank == CardRank::CARD_RANK_K
        return CardRank::CARD_RANK_A
    end
    return rank + 1
end

def prevValidAdjacent(rank)
    if rank == CardRank::CARD_RANK_A
        return CardRank::CARD_RANK_K
    end
    return rank - 1
end

def validSameSuitGroup(cards)
    raise unless caller[0].split(':')[0] == __FILE__
    raise ArgumentError, '\'cards\' argument is not an Array' unless cards.is_a? Array

    ii = 0
    cards.each do |c|
        if ii != 0 && ii != (cards.count - 1) && c.rank == CardRank::CARD_RANK_A
            # A must be first or last card; can't be in the middle!
            return false
        end
        ii += 1;
    end

    prev = nil;
    slop = 0;
    prevJ = 0;
    cards.each do |c|
        # if prev; puts "prev #{prev.name}" end
        # puts "slop #{slop}, prevJ #{prevJ}"
        # puts "c=#{c.name}"
        if c.suit != CardSuit::CARD_SUIT_JOKER
            if prev == nil
                # skip
            elsif slop == 0
                diff = 1 + prevJ;
                if validAdjacent(c.rank, prev.rank, diff) # prev after c
                    slop = -1
                elsif validAdjacent(prev.rank, c.rank, diff)
                    slop = 1
                else # not valid adjacent
                    return false
                end
            else # slop already found
                diff = 1 + prevJ
                if slop == 1
                    if !validAdjacent(prev.rank, c.rank, diff)
                        return false
                    end
                else # slop == -1
                    if !validAdjacent(c.rank, prev.rank, diff) # prev after c
                        return false
                    end
                end
            end
            prev = c;
            prevJ = 0; # always ignore previouse jokers
        else
            prevJ += 1;
        end
    end

    # if slop == 0 # only if no adjacent non-joker cards
    #     return true # always valid!
    # else
    #     # convert jokers to correct card
    #     convertJokersRec(cards, slop, 0, 0);

    #     # check if valid sequance

    # end

    # cards.each do |c|
    #     if c.suit == CardSuit::CARD_SUIT_JOKER
    #         # skip
    #     elsif $suit == CardRank::CARD_RANK_UNDEFINED
    #         # something wrong this should never happened
    #         puts "E: Invalid card name=#{c.name}";
    #         return false
    #     else
    #         if $suits[c.suit] > 0
    #             return false
    #         end # if
    #         $suits[c.suit] += 1;
    #     end # if
    # end # cards.each

    return true
end # validSameSuitGroup

def handValidateCardGroup(group)
    raise ArgumentError, '\'group\' argument is not an Array' unless group.is_a? Array

    if group.count < 3
        puts "E: Cards less than 3!"
        return false
    end # if
    # convert to array of cards
    $cards = convertArrayToCards(group)
    if !$cards
        return false;
    end # if

    # validate if array of cards are valid cards
    if !checkIfValidCards($cards)
        return false;
    end # if

    # check if group of same suit or sequance
    if isSameRank($cards)
        if !validSameRankGroup($cards)
            puts "E: Invalid group!"
            return false
        end
    elsif isSameSuit($cards)
        if !validSameSuitGroup($cards)
            puts "E: Invalid group!"
            return false
        end
    else
        puts "E: Invalid group!"
        return false
    end

    return true
end # handValidateCardGroup