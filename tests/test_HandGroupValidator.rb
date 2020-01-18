#!/usr/bin/ruby -w

require_relative "../src/HandGroupValidator.rb"
require_relative "Test.rb"


def test_handValidateCardGroup(test)
    test.checkIf(!handValidateCardGroup([]), __LINE__, __FILE__);
    # test.checkIf(!handValidateCardGroup([""]), __LINE__, __FILE__); # this will print error but should pass
    test.checkIf(!handValidateCardGroup(["Ah", "1c"]), __LINE__, __FILE__);
    test.checkIf(!handValidateCardGroup(["Ah", "1c", "2d"]), __LINE__, __FILE__);
    
    handValidateCardGroup(["3h", "3c", "3s"]);
    handValidateCardGroup(["Ah", "Ac", "As"]);
    handValidateCardGroup(["4h", "4c", "4s", "4d"]);
    handValidateCardGroup(["5h", "5d", "5d", "5s"]);
    handValidateCardGroup(["5h", "5c", "5d", "5s", "5c"]);
    handValidateCardGroup(["3h", "4h", "5h", "6h", "7h"]);
    handValidateCardGroup(["5h", "4h", "3h"]);
    handValidateCardGroup(["Qd", "Kd", "Ad"]);
    handValidateCardGroup(["Ac", "2c", "3c"]);
    handValidateCardGroup(["3c", "2c", "Ac"]);
    handValidateCardGroup(["5h", "7h", "6h"]);
    handValidateCardGroup(["5h", "7h", "8h"]);
    handValidateCardGroup(["Kh", "Ah", "2h"]);
    handValidateCardGroup(["3h", "1j", "3c"]);
    handValidateCardGroup(["1j", "4h", "4s"]);
    handValidateCardGroup(["1j", "2j", "6h"]);
    handValidateCardGroup(["Qh", "Kh", "1j"]);
    handValidateCardGroup(["2j", "2h", "3h"]);
    handValidateCardGroup(["2j", "3h", "5h"]);
    
    test.checkIf(!handValidateCardGroup(["2j", "3h", "5h"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["1j", "2j", "6h"]), __LINE__, __FILE__);
    test.checkIf(handValidateCardGroup(["3h", "4h", "5h", "6h", "7h"]), __LINE__, __FILE__);
end # test_Card


$testsList = Hash[
    "handValidateCardGroup method" => method(:test_handValidateCardGroup)
]

$test = SR_Test.new("Test HandGroupValidator", $testsList)
$test.run()
