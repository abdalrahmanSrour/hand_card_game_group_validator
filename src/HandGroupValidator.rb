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

def validSameSuitGroupRec(cards, index)
    if index == cards.count # last!
        return true
    end

    c = cards[index]

    if index == 0 # first one
        if c.suit != CardSuit::CARD_SUIT_JOKER
        end
    end
end

def validSameSuitGroup(cards)
    raise unless caller[0].split(':')[0] == __FILE__
    raise ArgumentError, '\'cards\' argument is not an Array' unless cards.is_a? Array

    prev = 0;
    cards.each do |c|
        if c.suit != CardSuit::CARD_SUIT_JOKER
            if prev == 0
                
        end
    end

    cards.each do |c|
        if c.suit == CardSuit::CARD_SUIT_JOKER
            # skip
        elsif $suit == CardRank::CARD_RANK_UNDEFINED
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
        puts "Same Rank"
        if !validSameRankGroup($cards)
            puts "E: Invalid group!"
            return false
        end
    elsif isSameSuit($cards)
        puts "Same Suit"
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