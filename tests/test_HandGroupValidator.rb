#!/usr/bin/ruby -w

require_relative "../src/HandGroupValidator.rb"
require_relative "Test.rb"


def test_handValidateCardGroup(test)
    test.checkIf(!handValidateCardGroup([]), __LINE__, __FILE__);
    # test.checkIf(!handValidateCardGroup([""]), __LINE__, __FILE__); # this will print error but should pass
    test.checkIf(!handValidateCardGroup(["Ah", "1c"]), __LINE__, __FILE__);
    test.checkIf(!handValidateCardGroup(["Ah", "1c", "2d"]), __LINE__, __FILE__);
    
    test.checkIf(handValidateCardGroup(["3h", "3c", "3s"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["Ah", "Ac", "As"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["4h", "4c", "4s", "4d"]), __LINE__, __FILE__);
    test.checkIf(!handValidateCardGroup(["5h", "5d", "5d", "5s"]), __LINE__, __FILE__);
    test.checkIf(!handValidateCardGroup(["5h", "5c", "5d", "5s", "5c"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["3h", "4h", "5h", "6h", "7h"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["5h", "4h", "3h"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["Qd", "Kd", "Ad"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["Ac", "2c", "3c"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["3c", "2c", "Ac"]), __LINE__, __FILE__);
    test.checkIf(!handValidateCardGroup(["5h", "7h", "6h"]), __LINE__, __FILE__);
    test.checkIf(!handValidateCardGroup(["5h", "7h", "8h"]), __LINE__, __FILE__);
    test.checkIf(!handValidateCardGroup(["Kh", "Ah", "2h"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["3h", "1j", "3c"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["1j", "4h", "4s"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["1j", "2j", "6h"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["Qh", "Kh", "1j"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["2j", "2h", "3h"]), __LINE__, __FILE__);
    test.checkIf(!handValidateCardGroup(["2j", "3h", "5h"]), __LINE__, __FILE__);
    
    test.checkIf(!handValidateCardGroup(["2j", "3h", "5h"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["1j", "2j", "6h"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["3h", "4h", "5h", "6h", "7h"]), __LINE__, __FILE__);
end # test_Card


$testsList = Hash[
    "handValidateCardGroup method" => method(:test_handValidateCardGroup)
]

$test = SR_Test.new("Test HandGroupValidator", $testsList)
$test.run()
