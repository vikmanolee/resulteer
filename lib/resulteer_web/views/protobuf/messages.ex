defmodule ResulteerWeb.Protobuf.Messages do
  use Protobuf, """
  message Results {
		message Result {
      optional string date = 1;
      optional string homeTeam = 2;
      optional string awayTeam = 3;
      optional uint32 fullTimeHomeGoals = 4;
      optional uint32 fullTimeAwayGoals = 5;
      optional string fullTimeResult = 6;
      optional uint32 halfTimeHomeGoals = 7;
      optional uint32 halfTimeAwayGoals = 8;
      optional string halfTimeResult = 9;
  	};

  	repeated Result results = 1;
  }
  """
end
